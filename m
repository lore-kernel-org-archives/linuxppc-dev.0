Date: Tue, 27 Apr 2004 12:48:20 +0200
From: Magnus Damm <damm@opensource.se>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: mgroeger@sysgo.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
Message-Id: <20040427124820.2f3aa14c.damm@opensource.se>
In-Reply-To: <408E2AF4.2050907@fh-landshut.de>
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>
	<20040426220944.GI19246@smtp.west.cox.net>
	<408E000A.6040303@fh-landshut.de>
	<Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com>
	<408E1ED0.4050404@fh-landshut.de>
	<Pine.LNX.4.56.0404271119270.2567@mag.sysgo.com>
	<408E2AF4.2050907@fh-landshut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 27 Apr 2004 11:42:12 +0200
Oliver Korpilla <okorpil@fh-landshut.de> wrote:

> This was the first I checked - CONFIG_EXT2_FS is set to y. Besides, I
> tried doing the same with a cramfs initrd - won't work either. Cannot
> say whether I configured that right.
>
> Maybe this is an endianess problem in my initrds?

As long as you use ext2 you should not have any endian problems.

It might be tempting to use other fancy filesystems, but I don't
like endian problems so I usually stick to ext2. I create my
ext2 initrds on x86 systems and use them on ppc without problems.

/ magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
