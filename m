Message-Id: <199901082349.AAA13864@denx.muc.de>
To: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.muc.de>
Subject: MBX860: How to boot with initrd ?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Sat, 09 Jan 1999 00:49:17 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm trying to boot with `initrd' support on a MBX860 system.  I  know
how  to  configure  and build the kernel, and I know how to build the
disk image, and I even seem to be able  to  build  the  zImage.initrd
image.  But  I  must be missing something, because such an image will
not boot; all I see is:

	...
	Bytes Received =&941768, Bytes Loaded =&941768
	Bytes/Second   =&134538, Elapsed Time =7 Second(s)loaded at:     00210000 0030E440
	relocated to:  00100000 001FE440
	board data at: 023F4228 023F4250
	relocated to:  00200100 00200128
	zimage at:     00216000 002674C9
	relocated to:  023A3000 023F44C9
	initrd at:     002674C9 002E45DF
	avail ram:     0030E440 023A3000

	Linux/PPC load: console=tty0 console=ttyS0,9600n8
	Uncompressing Linux...done.
	Now booting the kernel

Then the system hangs, and I have to reset it.


Any help appreciated...

Let's assume that I want to populate the `initrd'  with  exactly  the
same  files  as  included  in the `mbxroot.min.tgz' example. [This is
what I'm  testing  with,  additionally  I  have  only  added  a  link
`/linuxrc' which points to `/bin/sh'].

What might be missing? I'm sure it's just  a  minor  detail,  however
critical :-(

TIA,

Wolfgang

-- 
Phone:  (+49)-89-95720-110   Fax: (+49)-89-95720-112   wd@denx.muc.de
Office: (+49)-89-722-27328               Wolfgang.Denk@ICN.Siemens.DE
He who hesitates is not only lost, but miles from the next exit.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
