Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id D0A27DE05B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 14:28:35 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] 4xx: Fix 460GT support to (re-)enable the FPU
Date: Sat, 24 May 2008 06:28:32 +0200
References: <1211547896-4263-1-git-send-email-sr@denx.de>
	<20080523124727.628fa28b@zod.rchland.ibm.com>
In-Reply-To: <20080523124727.628fa28b@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805240628.32228.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 May 2008, Josh Boyer wrote:
> > Since AMCC now reports that the 460GT *has* an FPU, we should enable it
> > (again). This patch basically reverts my patch
> > acb0142bf01c0ebe18f09e37814451ee6a873e27 ([POWERPC] 4xx: Fix 460GT
> > support to not enable FPU), which disabled the FPU upon AMCC request.
> >
> > Sorry about the confusion here.
>
> I should just be able to use git-revert on that commit then, right?

Yes, this should do it too.

Best regards,
Stefan
