Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: "Leiying Du" <ldu@solectek.com>,
	"'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BDI2000 debug zImage
Date: Wed, 12 Mar 2003 09:53:59 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNOEBMCJAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <004901c2e83f$e9643f40$6649a8c0@LEIYINGDU>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>But the board will get into the
>check stop state if I type in go command.

I have the same problem if I simply type "go" - however
if I enter "go 0x500000" it works as expected.
If you have not already done so, try placing an absolute address
after the "go" and see what happens.

Jerry Walden

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Leiying
Du
Sent: Tuesday, March 11, 2003 9:35 PM
To: 'LinuxPPC-Embedded'
Subject: BDI2000 debug zImage



I'm using the BDI2000 with firmware version 1.12 to debug the zImage file
that I made. The zImage file can be flashed into the ROM and boot up
properly. From the BDI2000 telnet interface, I type in load

Loading zImage , please wait ....
- File offset 0x00010000 to address 0x00500000 size 25380
- File offset 0x0001C570 to address 0x0050C570 size 3160272
Loading program file passed

Then I can single step from the 0x500000. But the board will get into the
check stop state if I type in go command.

The host section in the BDI2000 configuration file are flollow:
FILE    zImage
FORMAT  IMAGE
LOAD      MANUAL

Is this the correct way to debug kernel with initrd? Thanks.



Ly


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
