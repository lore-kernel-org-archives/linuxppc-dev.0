Date: Fri, 29 Sep 2000 19:25:05 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: R Shapiro <rshapiro@bbn.com>, Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10009291631490.15714-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.21.0009291917490.1084-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 29 Sep 2000, Michael Schmitz wrote:

> That's not fixable at the X level (well, technically it is but I can't
> figure out how and the X people refuse to consider that method). You will
> need to boot via OF and yaboot (or equivalent oldworld) directly, not via
> BootX to avoid the PCI resource conflict. Alternative: fix the resource
> conflict at the kernel level, new patch by me in the works.

Hmm if you think that its fixable in the X level then we should give it
a try, i can't see how though unless we get X to accept this allocations
(are they legal ?). Any relocation is going to break the fbdev side since
there is no way to inform the atyfb driver about this changes.

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
