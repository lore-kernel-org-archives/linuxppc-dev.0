MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: CFI flash support for AMD chips
Date: Mon, 13 Aug 2001 17:17:11 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B5063419@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to use the CFI flash support for AMD chips. I selected the
CFI support in kernel configuration and defined the flash memory map on
my board ( CFI Flash device in Physical memory map). I see that CFI is
able to find the flash devices on my board correctly. Now, do I need to
create a /dev/flash device in the dev directory? What Major, Minor
numbers do I use? How do I actually use this driver???

Thank you,
Navin.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
