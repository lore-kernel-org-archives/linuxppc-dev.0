Date: Thu, 5 Oct 2000 16:06:40 -0400 (EDT)
From: Eric Lowe <elowe@myrile.madriver.k12.oh.us>
To: Michel Lanners <mlan@cpu.lu>
cc: nicoya@apia.dhs.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 madness!
In-Reply-To: <200010050557.HAA00748@piglet.grunz.lu>
Message-ID: <Pine.BSF.4.10.10010051605230.59019-100000@myrile.madriver.k12.oh.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

> > I first tried compiling a 2.2.17 kernel with the latest ide patch, which
> > resulted in a machine check on startup. bummer.
>
> That could have been PCI problems....
>
> Anyway, I'd suggest starting with:
>
> 1. Andre Hedrick's ATA patches (but I suppose you knew that), available
>    somewhere on kernel.org, users/hedrick. AFAIK, the 2.2 patches
>    _don't_ contain support for the U/100, though...
>
> 2. Get my PCI patches, available here:
>
>    http://www.cpu.lu/~mlan/linux/dev/pci.html
>
> ...and cross fingers ;-)
>

Hmm.. I'll give your patches a try.  I tried a 2.4 kernel on an MVME 2700
here yesterday and it had some PCI problems where 2.2.17 works..

--
Eric Lowe
FibreChannel Software Engineer, Systran Corporation
elowe@systran.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
