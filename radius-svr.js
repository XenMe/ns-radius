/**
 * Created by froyoy on 2/16/2017.
 */
"use strict";

const dgram = require('dgram');
const srv = dgram.createSocket('udp4');
const client = dgram.createSocket('udp4');
const radius = require('radius');

const RADIUS_SECRET='2003.r2';
const SMS_TOKEN = '888888';
const TF_FAILED_TOKEN = '000000';

srv.on('error',(e)=>{
    console.log(e);
srv.close();
});

srv.on('message',(msg, rinfo)=>{
    let request = radius.decode({packet: msg, secret: RADIUS_SECRET});
    //console.log(request);
    console.log('==>',request.identifier,request.attributes);

    let username = request.attributes['User-Name'];
    let password = request.attributes['User-Password'];

    let challenge;
    if(password == SMS_TOKEN) {
        //reply with Access-Accept
        console.log('Response with Access-Accept.');
        challenge = radius.encode_response({
            packet: request,
            code: "Access-Accept",
            secret: RADIUS_SECRET
        });
    } else if (password == TF_FAILED_TOKEN){
        //reply with Access-Reject
        console.log('Response with Access-Reject.');
        challenge = radius.encode_response({
            packet: request,
            code: "Access-Reject",
            secret: RADIUS_SECRET
        });

    } else {
        //reply with Access-Challenge
        console.log('Response with Access-Challenge.');
        let otpbuf = new Buffer('0101000505','hex');
        challenge = radius.encode_response({
            packet: request,
            code: "Access-Challenge",
            secret: RADIUS_SECRET,
            add_message_authenticator: false,
            attributes:[
                ['Reply-Message',`SMS Token(TestOnly: ${SMS_TOKEN})`],
                ['EAP-Message',otpbuf],
                ['Session-Timeout',30],
            ]
        });
    }

    srv.send(challenge, 0, challenge.length, rinfo.port, rinfo.address, () =>{

    });
});

srv.on('listening',()=>{
    let addr = srv.address();
    console.log(`server listening ${addr.address}:${addr.port}`);
});

srv.bind(1812);