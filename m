Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B4BDDDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 06:31:18 +1100 (EST)
Date: Tue, 29 Jan 2008 13:31:38 -0600
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 4/4] 82xx: MGCOGE support
Message-ID: <20080129193138.GA4304@loki.buserror.net>
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
	<479EFE7F.4000104@denx.de>
	<20080129192454.GC4051@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080129192454.GC4051@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 29, 2008 at 01:24:54PM -0600, Scott Wood wrote:
> On Tue, Jan 29, 2008 at 11:22:55AM +0100, Heiko Schocher wrote:
> > +		*pram_base = res.start;
> 
> First of all, use out_be32() rather than direct dereferencing.

Err, I meant out_be16() of course. :-P

-Scott
