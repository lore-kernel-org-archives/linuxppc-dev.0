Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux on 8260 using ELDK..Help?!? 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 5 Sep 2002 10:20:44 +0200
Message-ID: <1E354700654661418593A0D6B5A9D41008943F@mail.azisa.co.za>
From: "Flavio Pereira" <fpereira@azisa.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang

> I recommend to return to the original code, and get this working. You
> can probably use the driver in our  CVS  as  reference;  we  fixed  a
> couple of issues for example in the area of BRG assignment.

I have returned to the original uart.c. Although it still kills my
serial port it has nothing to do with the unable to open initial
console. Will the original uart.c I still get logging in
/var/log/messages and I can see it is still doing the same thing. Yes,
uart.c is probably something that I will still have to look at, but it
is not the root cause of my original problem. Any more suggestions would
be appreciated since I feel I've hit the brick wall quite severely now.
Besides file permissions (which Im conviced are fine now) what else
could cause the kernel to not be able to open a console?

Regards
Flavio


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
