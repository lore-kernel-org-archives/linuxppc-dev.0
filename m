Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D471DDF55
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 00:44:14 +1000 (EST)
In-Reply-To: <20070928190616.GB20213@loki.buserror.net>
References: <20070928190616.GB20213@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5DEF6884-7AAF-4B2C-900B-555EDE3715E8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
Date: Tue, 2 Oct 2007 09:43:58 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 28, 2007, at 2:06 PM, Scott Wood wrote:

> The way the current CPM binding describes available multi-user (a.k.a.
> dual-ported) RAM doesn't work well when there are multiple free  
> regions,
> and it doesn't work at all if the region doesn't begin at the start of
> the muram area (as the hardware needs to be programmed with offsets  
> into
> this area).  The latter situation can happen with SMC UARTs on  
> CPM2, as its
> parameter RAM is relocatable, u-boot puts it at zero, and the  
> kernel doesn't
> support moving it.
>
> It is now described with a muram node, similar to QE.  The current CPM
> binding is sufficiently recent (i.e. never appeared in an official  
> release)
> that compatibility with existing device trees is not an issue.
>
> The code supporting the new binding is shared between cpm1 and  
> cpm2, rather
> than remain separated.  QE should be able to use this code as well,  
> once
> minor fixes are made to its device trees.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>

applied.

- k
