Date: Fri, 29 Sep 2000 16:34:44 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <14804.42077.837821.274373@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10009291631490.15714-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > Mr Shapiro, please test if this makes the ati driver work in your
>  > triple-head box.
>
> No luck.
>
> Booting with BootX, the ati driver still hoses linux when X starts.  I

That's not fixable at the X level (well, technically it is but I can't
figure out how and the X people refuse to consider that method). You will
need to boot via OF and yaboot (or equivalent oldworld) directly, not via
BootX to avoid the PCI resource conflict. Alternative: fix the resource
conflict at the kernel level, new patch by me in the works.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
