From: Graf Alex <alex.graf@siemens.com>
To: "'somshekar chandrashekar kadam'" <som_kadam1@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Message-ID: <791B3205DB661A42B4BFE5464A7D1D0204B36C64@chzugexch01.abatos.com>
Subject: AW: compact flash
Date: Mon, 29 Sep 2003 09:08:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


which compact flash card can i use with maximum memory ,
>> u can use any CF (compact flash) card. The thing is, how you address the
card. PCMCIA or CF. With PCMCIA u can address up to 64 MB. With IDE much
more as any CF card memory has :-)

apart from kernel support for hot pluggable , IDE support and
flash file system support , what are things i need to get compact
flash working , I am confused here
>> best is to start work with ELDK from denx.de. There is the PCMCIA and IDE
support solved.

MPC860 provide interface for PCMCIA, which can be interfaced to
COMPACT FLASH also if i am not wrong ?
>> No, u are rigth.

cheers

Alex Graf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
