Message-ID: <05E0AA82E68BD411A4CA00508BC5CE9A02DC64D4@engnorth.kidd.co.za>
From: Pirow Engelbrecht <PirowE@kentron.co.za>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: MetroTRK and Motorola Sandpoint 7410
Date: Tue, 4 Dec 2001 16:08:53 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get the MetroTRK debugger working on the Motorola Sandpoint
board (7410 processor).
It seems from the manual that I have two options:
1. I load MetroTRK (using DINK) into the first of the two flashes on the
MPPMC card,
2. I burn MetroTRK to ROM, replacing DINK

I've tried both options now. The first time using the s-record file supplied
with codewarrior (ROM image adress 0xfff000000), and the second time using a
recompiled s-record file with a ROM image adress 0x0000000.

Am I correct in saying that I should place the code at the start of the ROM
(which would be memory mapped to 0xfff000000)? Any other tips or other
comments (especially on obvious mistakes I've made) would be welcomed.

Thanxs
Pirow



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager at contentadmin@kentron.co.za.
**********************************************************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
