Date: Mon, 17 Sep 2001 09:38:42 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Matt Porter <mporter@mvista.com>
Cc: Xavier Grave <grave@ipno.in2p3.fr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mvme5100 memory model ?
Message-ID: <20010917093842.C10416@ipnpcu5.in2p3.fr>
References: <20010913162250.C5558@ipnpcu5.in2p3.fr> <20010913051235.A7990@cx258813-a.chnd1.az.home.com> <20010913175703.C6152@ipnpcu5.in2p3.fr> <20010914102219.B3783@beef.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20010914102219.B3783@beef.az.mvista.com>; from mporter@mvista.com on ven, sep 14, 2001 at 19:22:19 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Le ven, 14 sep 2001 19:22:19, Matt Porter a écrit :
>
> [Move to linuxppc-embedded]
>
> On Thu, Sep 13, 2001 at 05:57:03PM +0200, Xavier Grave wrote:
> >
> > > > "chrp-like".  CFGA and CFGD are not at chrp compliant locations
> > > due to limitations of the hawk smc.  As far as PCI I/O and Mem
> > > space, it is the same.
> >
> > One more question so : why the Hawk chip doesn't appear in the
> /proc/iomem
>
> /proc/iomem displays a a list of iomem_resource resources.  I'm think
> that although it is being used, the MPIC mem base address is never
> claimed so it doesn't show up.  Feel free to fix it.

Thanks for your answers,

I'll try to fix it, I'll try a look in the prep_* files to get some
inspiration.

O+ xavier
--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
