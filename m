Message-ID: <39D4C5CE.8A9E48F2@student.ethz.ch>
Date: Fri, 29 Sep 2000 18:39:42 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
References: <Pine.LNX.4.21.0009291917490.1084-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:
>
> On Fri, 29 Sep 2000, Michael Schmitz wrote:
>
> > That's not fixable at the X level (well, technically it is but I can't
> > figure out how and the X people refuse to consider that method). You will
> > need to boot via OF and yaboot (or equivalent oldworld) directly, not via
> > BootX to avoid the PCI resource conflict. Alternative: fix the resource
> > conflict at the kernel level, new patch by me in the works.
>
> Hmm if you think that its fixable in the X level then we should give it
> a try, i can't see how though unless we get X to accept this allocations
> (are they legal ?).

I don't know, but I'm pretty sure that Egbert or whoever made the code disable
it has done so for a reason.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
