Date: Wed, 24 May 2000 13:04:10 -0400
From: Simon Piette <spiette@generation.net>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Promise Ultra/66
Message-ID: <20000524130410.C1169@xim.bellglobal.com>
Reply-To: spiette@generation.net
References: <20000516133216.A760@xim.bellglobal.com> <200005162039.WAA00813@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200005162039.WAA00813@piglet.grunz.lu>; from mlan@cpu.lu on Tue, May 16, 2000 at 10:39:32PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

* Michel Lanners (mlan@cpu.lu) [000516 16:51]:
> > For the former (2.2.12 kernel), I got the ide-2.2.12 patch form Andre
> > Hedrick (http://www.kernel.org/pub/linux/kernel/people/hedrick)
> > and applied the patch from Michel Lanners
> > (http://lists.linuxppc.org/listarcs/linuxppc-dev/199909/msg00146.html)
>
> Forget about these old patches. Go to my PCI page:
>
> http://www.cpu.lu/~mlan/linux/dev/pci.html
>
> and get yourself my latest patches for either 2.2.15 (kernel.org) or
> 2.3.99-pre7 (linuxcare.au) kernels. For 2.2.15, you need Andre's patches
> in addition to mine. Apply his IDE patches first.

Great! It's working without a hitch (but with a few kernel args!).

I have to say that I can't put my card in slot 3 or 4, but only in 1 or
2. Not an issue for me but you may want to know ...

Also, the Promise Card is the only one IDE controller on my Mac, but it
gets detected at ide2 and ide3. Not an isssue for me neither :-)

Thanks for your work! I'll post instructions on linuxppc-user ...

Cheers,

Simon

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
