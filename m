Message-ID: <383A6B90.7734B3D5@ssl.co.uk>
Date: Tue, 23 Nov 1999 10:25:20 +0000
From: Sacha Varma <sacha@ssl.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: tv tuner/video
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Some TV Tuner card/LinuxPPC questions:

1. What is the state of tv card support on LinuxPPC? I've searched the
linuxppc-dev logs and seen some announcements of bt848 support. I'm aware of the
video4linux/V4L2 work; is this supported by the PPC kernel or are there PCI
nuances that need addressing first?

2. The bt848 cards I've seen seems to offer v. limited real-time continuous
capture (320 x240 == 1/4 NTSC); I don't know if this is a limitation of the
chipset or the cards. I'm looking for full streaming PAL capture to memory. Is
this beyond the bandwidth of PCI? If so, is it usual for cards that offer this
to do hardware compression first?


Any help much appreciated. I'm largely ignorant about the architecture involved
in getting video out of the coax from my aerial and into RAM.

--
sacha varma : system simulation ltd : sacha@ssl.co.uk

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
