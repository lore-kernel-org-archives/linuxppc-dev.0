Date: Thu, 7 Sep 2000 13:16:52 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Dan Malek <dan@netx4.com>
cc: frowand@mvista.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        Rolf Liu <rolfl@sc23.sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: question about 'r2' !!!
In-Reply-To: <39B6B21C.9A3ACA5B@embeddededge.com>
Message-ID: <Pine.LNX.4.10.10009071312200.24134-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > If you're unable to use gcc for building your kernels, ....
>
> With the gcc/gas specific syntax, and the reliance on gcc inline
> assembler, there is lots of work to do to make something else
> compile this software in any case.

I know. He's been advised to forget compiling the kernel with that other
compiler numerous times on this list. He happily seems to ignore that
advice and try it anyway, so who am I to dissuade someone from a great
learning experience?

> Then, all you have done is the easy part, which is getting a kernel
> to boot.  What about applications, libraries and other tools that
> actually make a system do something?

I'd assume that you can just use any old distribution (unless you broke
binary compatibility).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
