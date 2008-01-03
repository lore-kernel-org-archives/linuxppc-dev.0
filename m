Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D672DDE9A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 04:38:23 +1100 (EST)
Date: Thu, 3 Jan 2008 11:37:17 -0600
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/5] [POWERPC] 8xx: Use machine_*_initcall() hooks in
	platform code
Message-ID: <20080103173717.GA4287@loki.buserror.net>
References: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
	<20080102193233.24178.74501.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080102193233.24178.74501.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 02, 2008 at 12:32:51PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/powerpc/platforms/8xx/ep88xc.c          |    5 ++---
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 ++---

How about mpc86xads_setup.c?

-Scott
