Date: Sun, 6 Oct 2002 18:31:20 -0700
From: Matt Porter <porter@cox.net>
To: Andrew May <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021006183120.A17129@home.com>
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com> <20020930040143.GF10265@zax> <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax> <3D9AA452.5070004@elsoft.ch> <20021003011233.GC1102@zax> <20021006052314.GG27824@acmay.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021006052314.GG27824@acmay.homeip.net>; from acmay@acmay.homeip.net on Sat, Oct 05, 2002 at 10:23:14PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Oct 05, 2002 at 10:23:14PM -0700, Andrew May wrote:
>
> On Thu, Oct 03, 2002 at 11:12:33AM +1000, David Gibson wrote:
> >
> > Fair enough.  I'm just trying to come up with the simplest approach
> > that still provides the flexibility we need.  Based on the evidence
> > immediately available, what I posted seemed like it.  How about you
> > tell me something about the non-standard PCI mappings, so I can come
> > up with something better.
>
> It would be nice to have the option to let the boot loader set the
> mapping. I have been happy with getting things done in PPCBoot and
> ripping out the PCI scanning in the kernel.

Yes, that's the ideal situation and going to what David and I would
like to see makes that yet another simple fallout feature.

Your custom port using a good implementation of PPCBoot simply
would not call the pci macro init library nor would it use pci_auto.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
