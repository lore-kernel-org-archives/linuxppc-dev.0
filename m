Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 20471DE0B5
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 22:57:15 +1000 (EST)
Date: Fri, 25 Apr 2008 14:57:24 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
In-Reply-To: <20071023212404.GA30942@loki.buserror.net>
Message-ID: <Pine.LNX.4.64.0804251454050.6045@axis700.grange>
References: <20071023212404.GA30942@loki.buserror.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus,

is there any specific reason, why out of these 7 patches only the first 
one made it into the mainline? AFAICS, there has been only one comment, 
suggesting to replace printk with dev_err on two occasions in one of 
the patches...

Thanks
Guennadi
---
Guennadi Liakhovetski
