Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56327DDFDE
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 09:52:47 +1000 (EST)
Date: Tue, 21 Apr 2009 19:14:45 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/85xx: Add P2020DS board support
Message-Id: <20090421191445.9fda1786.kim.phillips@freescale.com>
In-Reply-To: <1240348762-13581-1-git-send-email-galak@kernel.crashing.org>
References: <1240348762-13581-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Apr 2009 16:19:22 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> +		crypto@30000 {
> +			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
> +				     "fsl,sec2.1", "fsl,sec2.0";

should be:

compatible = "fsl,sec3.1", "fsl,sec3.0", "fsl,sec2.4",
	     "fsl,sec2.2", "fsl,sec2.1", "fsl,sec2.0";

> +			fsl,exec-units-mask = <0x9fe>;

and:

fsl,exec-units-mask = <0xbfe>;

to include the SNOW unit.

Kim
