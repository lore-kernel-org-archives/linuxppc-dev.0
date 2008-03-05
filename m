Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDB61DDE10
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 04:34:04 +1100 (EST)
Date: Wed, 5 Mar 2008 11:34:37 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] Fix wrapper platform for adder875, and combine defconfigs.
Message-ID: <20080305173437.GA14946@loki.buserror.net>
References: <20080220183338.GA9282@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080220183338.GA9282@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 12:33:38PM -0600, Scott Wood wrote:
> This fixes the following bug:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051979.html

Can someone apply this for 2.6.25?  Adder875 does not currently build.

-Scott
