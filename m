Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Weird flash problem with saveenv
Date: Wed, 15 Aug 2001 16:18:23 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B5063420@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have AM29LV640DU (128 uniform sectors 32kwords each) chips on my
custom board. I have been able to do "saveenv" on all but one of my
boards. I notice that the erase is not performed correctly and
therefore, the following write fails. Well, I initially thought it was a
bad hardware issue, but I have no problem when I use the BDI to program
the same exact environment sectors (I am using 2 of them). BDI erases
and writes to these sectors without any issues. The erase and write
fails only in PPCBOOT. And before I get queries from someone, I am darn
sure that I am using the same exact ppcboot image on each of my boards.
So, I am in a fix since I cannot saveenv to the flash and I cannot blame
the hardware. And this happens only on ONE board.

Any ideas?????

Thank you,
Navin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
