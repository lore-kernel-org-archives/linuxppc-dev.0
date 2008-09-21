Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D599DDE98
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Sep 2008 17:37:16 +1000 (EST)
Date: Sun, 21 Sep 2008 00:36:51 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/fsl: Refactor device bindings
In-Reply-To: <Pine.LNX.4.64.0807081708440.20286@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0809202357180.6621@t2.domain.actdsltmp>
References: <Pine.LNX.4.64.0807081708440.20286@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Jul 2008, Kumar Gala wrote:
> Moved Freescale SoC related bindings out of booting-without-of.txt and into
> their own files.
>
> Signed-off-by: Kumar Gala <galak at kernel.crashing.org>
> ---
>
> We need to resolve some conflicts in cpm.txt and qe.txt but that will be a
> followup patch.
> 
> - k
>
>  Documentation/powerpc/booting-without-of.txt       | 1218 +-------------------

It looks like the part of the this patch that deleted all the bindings from
booting-without-of.txt was paritially reverted in a subsequent merge.  The
table of contents still lists all the sections that were removed and sections
r) and s) were added back in.
