Message-ID: <20040825020020.87711.qmail@web15606.mail.cnb.yahoo.com>
Date: Wed, 25 Aug 2004 10:00:20 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
To: "Peter 'p2' De Schrijver" <p2@mind.be>,
	Patrick Huesmann <tricknology@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040824085118.GO2698@mind.be>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter 'p2' De Schrijver <p2@mind.be> wrote£º
>
> On Mon, Aug 23, 2004 at 05:17:15PM +0200, Patrick Huesmann wrote:

> > 3) Is there a way to get a self-decompressing kernel image? ARM
> > linux provides a zImage which the cpu just has to jump into (with
> > some registers initialized) and then decompresses vmlinux by itself.
[snip]
> Yes. look at arc/ppc/boot/simple for some targets which have a
> self-decompressing kernel. (Amongst which is our port to the Insight
> V2PRO board).

OK, new things learned. But still one point I'd like
to add, that's both U-Boot and PlanetCore convert
linux kernel zImage.embedded image before booting.
U-Boot use mkimage, PlanetCore with dd. This depends
on bootloader.

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
