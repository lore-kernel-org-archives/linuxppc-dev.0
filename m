Message-ID: <39D45ACA.9E151BCC@student.ethz.ch>
Date: Fri, 29 Sep 2000 11:03:06 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
References: <Pine.LNX.4.21.0009281937470.7326-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:
>
> On Thu, 28 Sep 2000, Michel [iso-8859-1] Dänzer wrote:
>
> > Michael Schmitz wrote:
> >
> > > Nope, the syntax should be OK. Question is does the ati driver parse
> > > that option if fb_open_pci is used.
> >
> > I just rsynced Ani's tree, and the ati driver doesn't. Ani, why not?
>
> Only the fbdev and glint drivers use this option, all the others get the
> fbdev device from the BusID option, unfortunately fbdev_open_pci() will open
> the *first* device that matches the device so if you have more than 2
> devices it will map the first one again with bad results.
> Geert posted recently a patch recently for fbdev_open_pci so it will do the
> right thing (i never tested it though) give it a try.

Yep, I've got that in my local CVS tree and will submit it when we've ironed
out the remaining issues.


However, I think the "fbdev" option should also be available, it might be more
straightforward for some users than the bus ID. Would it also be possible to
go the opposite way fbdev -> pcidev and then claim the PCI device?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
