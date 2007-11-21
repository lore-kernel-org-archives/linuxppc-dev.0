Return-Path: <SRS0=WtMl=QO=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id BF16BDDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 01:05:54 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH 0/14] powerpc: 4xx PCI and PCI-X support
Date: Wed, 21 Nov 2007 15:04:12 +0100
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121072348.7fff79a9@weaponx>
In-Reply-To: <20071121072348.7fff79a9@weaponx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711211504.13003.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 November 2007, Josh Boyer wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Here's a set of patches that bring PCI and PCI-X support for
> > 4xx (PCIe still missing) in arch/powerpc.
> >
> > This is for review before I ask paulus to pull that into his
> > for 2.6.25 tree. Some of the patches still need a bit more
> > testing vs. regressions on other platforms such as the
> > 64 bits resource fixup one.
>
> I'm starting my 2.6.25 branch today.  I'll probably throw these in
> there after I've tested a bit, since I need them to make further
> progress with 4xx anyway.

Yes, it would be great to have an "official" repo with all the new 4xx stuff 
(PCI, EMAC...) stuff.

Thanks.

Best regards,
Stefan
