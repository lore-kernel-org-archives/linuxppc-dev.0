Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B270DDFAE
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 01:50:48 +1000 (EST)
Date: Wed, 18 Jun 2008 10:50:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 1/2] fs_enet: fix checkpatch.pl problems
Message-ID: <20080618155036.GB3887@loki.buserror.net>
References: <1213743794-3537-1-git-send-email-jrigby@freescale.com>
	<1213743794-3537-2-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1213743794-3537-2-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>, jeff@garzik.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 05:03:13PM -0600, John Rigby wrote:
>  static int __devinit find_phy(struct device_node *np,
> -                              struct fs_platform_info *fpi)
> +			      struct fs_platform_info *fpi)

Please don't make this sort of change.  Spaces were used deliberately,
because it's alignment rather than indentation, and using tabs would make
things be unaligned with tab sizes other than 8, and (as can be seen above)
in patches.

Unfortunately, it's non-trivial to make checkpatch tell the difference
between the two (it would need to parse the language rather than do a simple
regex).

-Scott
