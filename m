Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 1D4E9DE46B
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 02:41:51 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] 4xx: Fix problem with new TLB storage attibute
	fields on 440x6 core
Date: Tue, 6 May 2008 18:41:44 +0200
References: <1209970399-4464-1-git-send-email-sr@denx.de>
	<20080506100117.22c88b09@zod.rchland.ibm.com>
In-Reply-To: <20080506100117.22c88b09@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805061841.44277.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 06 May 2008, Josh Boyer wrote:
> > The new 440x6 core used on AMCC 460EX/GT introduces new storage attibure
> > fields to the TLB2 word. Those are:
> >
> > Bit  11   12   13   14   15
> >      WL1  IL1I IL1D IL2I IL2D
> >
> > With these bits the cache (L1 and L2) can be configured in a more
> > flexible way, instruction- and data-cache independently now. The "old" I
> > and W bits are still available and setting these old bits will
> > automically set these new bits too (for backward compatibilty).
> >
> > The current code does not clear these fields resulting in disabling the
> > cache by chance. This patch now makes sure that these new bits are
> > cleared when the TLB2 word is written.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
>
> Finally catching back up with email.  This looks like .26 material,
> correct?

Definitely, yes.

Best regards,
Stefan
