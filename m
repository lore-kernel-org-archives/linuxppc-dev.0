Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <01139FC052A0D411900B00508B9535FC047BC37F@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: The relationship between hhl 2.0 and FEC driver
Date: Thu, 27 Dec 2001 19:31:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,
I am trying to make the FEC driver work under HardHat 2.0 for ppc. But it is really aching.
My board is based on MPC 857T. It has both FEC and UTOPIA interface.
The UTOPIA uses the Port D as its data channel. And the FEC uses the PCMCIA Slot A instead.
Actually, I have made the FEC work under the common linux 2.4.2, also under linux 2.4.4 from Wolf.
But when I tried to make it work under hhl 2.0, also based on linux 2.4.2, it failed.
I even tried to use the work fec.c under linux 2.4.4 to replace the on under hhl 2.0, but no use.
I wonder what is the problem? what should I do to let fec.c work under hhl 2.0?
Any suggestions are really appreciated!

Aside words: why can't I set the UT bit of Port D PAR? when I try to set that bit, the kernel just
bother on this statement and will not go on.

Thanks very much

Rolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
