Message-ID: <A109131318C4D1119AC20060088DECE30B9832@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: "'Edson Ap. Seabra'" <seabra@cyclades.com>,
        Linux List
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Ramdisk using libc5
Date: Mon, 24 Jul 2000 14:42:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Try stripping all the debug info out--libc-2.1.2.so will be about 370k.

Lucinda

-----Original Message-----
From: Edson Ap. Seabra [mailto:seabra@cyclades.com]
Sent: Monday, July 24, 2000 2:29 PM
To: Linux List
Subject: Ramdisk using libc5



        I want to make a ramdisk image for a PPC board that provides
basic network services
such as ping, telnet, traceroute and ftp. I would like the final memory
image size less than 2 Mb. Only libc-2.1.2.so has 4 Mb.

Has  somebody  done this using libc5 ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
