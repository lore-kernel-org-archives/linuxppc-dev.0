Date: Fri, 28 Apr 2000 13:42:23 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: the problem with kernel format
In-Reply-To: <005201bfb0ca$c075ef20$bf0102c8@dell191.sc.mcel.mot.com>
Message-ID: <Pine.LNX.4.10.10004281340260.13173-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> How I can translate the ELF to BIN( BDX...)????????
> By the way, the visionPROBE provides a converter , which can
> only translate the usual ELF to BIN(BDX).
> But the kernel file is a compressed one(including vmlinux,bootloader,
> and other initializing code).So the converter can't translate the compressed
> one to BIN(BDX).

There should be a file called 'vmlinux' in the top level directory of your
kernel source. This is the kernel image, uncompressed, without boot loader
or decompressor, in ELF format. Seems your converter should like that file
better than zImage.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
