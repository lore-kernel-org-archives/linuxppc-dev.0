Message-ID: <20000130191924.10880.qmail@web1001.mail.yahoo.com>
Date: Sun, 30 Jan 2000 11:19:24 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: coexisting with Darwin (Mac-on-Linux and microkernel Linux/BSD), was Re: resizing macos partition
To: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> my computer problems]).  I generally do not mind taking chances with
> screwing something up when I am 'on a mission' to complete some goal.

	Go get em, bro!  :)

> hard drive (I only have one on my Macintosh).  So I installed Darwin which
> reformats/partitions the drive to create one MOSX partition, several other
> partitions (I do not know what they do), and the rest of the drive becomes

	So does Darwin now have a "normal" installer, rather than the original
"filesystem restore" approach?  When I tried it, it required a physically
separate source and target device, because it was going to basically
automatically format and unpackage itself in one piece like a monolithic
'restore' utility.
	Can Mac-on-Linux boot any OS other than MacOS 8.x?
	What would the odds be of MkLinux working with this BSD?  How would it be
integrated in terms of user experience?  Would we have to switch to two virtual
terminals?  Can Linux be the host interface, with BSD in a box?  How does
networking work -- do you assign an IP address to each OS like a multihomed
system?  If so, we could use MkLinux as the host interface and 'remotely' log
into Darwin.
	I cast my vote for the above to happen!  If anyone developing Mac-on-Linux or
Darwin needs any non-programming motivation like money, self esteem, or to
fulfill their last dying wish, toss it out and I'll see what I can do!

> also a lot of fun and a great experience.  Never underestimate the power of
> a fresh hard drive.

	Amen, brother!


=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
