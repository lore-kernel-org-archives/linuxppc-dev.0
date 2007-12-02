Return-Path: <SRS0=Nfrs=QZ=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 83D46DDE1B
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 09:01:06 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 12/24] powerpc: 4xx PLB to PCI Express support
Date: Sun, 2 Dec 2007 23:01:03 +0100
References: <20071130061155.41D71DDF5F@ozlabs.org>
	<200712021332.29074.sr@denx.de>
	<1196627621.13230.156.camel@pasglop>
In-Reply-To: <1196627621.13230.156.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712022301.03505.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 02 December 2007, Benjamin Herrenschmidt wrote:
> > So before digging into this deeper, I wanted to check if you don't
> > have a
> > slightly "better" version which passed your tests with the sky2 PCIe
> > card.
>
> Yup, looks I forgot a quilt ref or something. I'll check. I'll also give
> port 1 and 2 a go (after fixing the DT).
>
> I also want to change the config space code to use some fixmap type
> direct mapping/unmapping to remove bus number limitations as soon as
> Kumar has implemented the fixmap stuff, since he seems to be working on
> it now.

Great, thanks.

Best regards,
Stefan
