Date: Fri, 14 Sep 2001 10:22:19 -0700
From: Matt Porter <mporter@mvista.com>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mvme5100 memory model ?
Message-ID: <20010914102219.B3783@beef.az.mvista.com>
References: <20010913162250.C5558@ipnpcu5.in2p3.fr> <20010913051235.A7990@cx258813-a.chnd1.az.home.com> <20010913175703.C6152@ipnpcu5.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010913175703.C6152@ipnpcu5.in2p3.fr>; from grave@ipno.in2p3.fr on Thu, Sep 13, 2001 at 05:57:03PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[Move to linuxppc-embedded]

On Thu, Sep 13, 2001 at 05:57:03PM +0200, Xavier Grave wrote:
>
> > > "chrp-like".  CFGA and CFGD are not at chrp compliant locations
> > due to limitations of the hawk smc.  As far as PCI I/O and Mem
> > space, it is the same.
>
> One more question so : why the Hawk chip doesn't appear in the /proc/iomem

/proc/iomem displays a a list of iomem_resource resources.  I'm think
that although it is being used, the MPIC mem base address is never
claimed so it doesn't show up.  Feel free to fix it.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
