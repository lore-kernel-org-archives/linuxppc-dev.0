Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 26 Nov 2002 09:44:19 +0800
From: caixupeng <edmoon@huawei.com>
Subject: ppcboot, ebony , change baudrate function has bug.
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <001d01c294ed$569cecc0$92690b0a@DBKQW41X>
MIME-version: 1.0
Content-type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


when you set a new baudrate,

=> setenv  baudrate 38400
## Switch baudrate to 38400 bps and press ENTER ...


it will hang .

I find a way  to avoid it.
first, clear the baudrate with "setenv baudrate=xxxx"----it's wrong ,

but it can clear it.

and then "setenv baudrate 38400"
"saveenv"
reset and change the hyperterminal baudrate, it's run , and ok.

because it doesn't invoke the baudrate changing function.

                    edmoon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
