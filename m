Message-ID: <20000128225831.14202.qmail@web1006.mail.yahoo.com>
Date: Fri, 28 Jan 2000 14:58:31 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: Making an HFS+ Filesystem
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> What single-user-centric file system would make a good example?  I'm
> assuming that ext2 and ext3 would make good multi-user-centric file
> system examples.

	Oh.  Have you looked at FAT, VFAT, and UMSDOS?  How about HPFS and Amiga FFS?
These are all Linux-supported single-user-centric fs's, to varying degrees of
modernness and completeness.
	If I was you, I'd go look in /usr/src/linux/fs/ and
/usr/src/linux/Documentation/filesystems.
	Or maybe you're way beyond that and I have no clue, but I'm still giving you a
pat on the back :)

=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
