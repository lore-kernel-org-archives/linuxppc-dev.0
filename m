Message-ID: <38451447.BFB42D44@263.net>
Date: Wed, 01 Dec 1999 20:27:52 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: damm@kieraypc01.p.y.ki.era.ericsson.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: re:ask for help
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


really? I made a minix fs on my linux box run on i586 and dd it to a
image file. i checked this image file and  found the magic number in 
the struct of the super block is "8F 13". because i386 is little endian,
so the number is 0x138F. and then, i copied this file to the flash
memory
of the eval board and ran linux. this time the magic number read by
linux
is 0x8F13.

the main difference between the environments of yours and mine is that
you
put image on disk while i put it on flash. something must do some
transferring
work while read image from disk, maybe the disk driver. but i read the
flash
by this mean:
	int a;
	a = 0xFFFD0400;
        ret =*(int*)a;
so, no transfer is done.

i don't if my words right. does anyone have some idea?

Wang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
