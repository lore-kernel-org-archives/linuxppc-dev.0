Message-ID: <20040824100145.58250.qmail@web15608.mail.cnb.yahoo.com>
Date: Tue, 24 Aug 2004 18:01:45 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
To: Patrick Huesmann <tricknology@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <27642.1093338875@www70.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Huesmann <tricknology@gmx.de> wrote£º

> > > 3) Is there a way to get a self-decompressing kernel image?
> >
> > Yes. look at arc/ppc/boot/simple for some targets which have a
> > self-decompressing kernel. (Amongst which is our port to the Insight
> > V2PRO board).
>
> Hmm. The denx tutorial states that the bootloader *must* decompress
> the kernel. If that's not true (anymore), then I might not have to use
> u-boot as second stage bootloader.

There isn't *MUST* decompress in U-Boot because U-Boot
can boot compressed and unconpressed kernel
respectively.In addition, if using U-Boot as second
stage bootloader,the process couldn't easier than
porting U-Boot on your custom board. I never thought a
so-called boot loader couldn't boot a standard linux
kernel.:-)

Good luck!

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
