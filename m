Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E437DEFD6
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:03:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3HF3LfT029077
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 08:03:21 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3HF3Ksv013497
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 10:03:21 -0500 (CDT)
Date: Thu, 17 Apr 2008 10:03:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] fsl: Convert dts to v1 syntax
Message-ID: <20080417150320.GB22368@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804170946470.18068@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0804170946470.18068@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 09:47:24AM -0500, Kumar Gala wrote:
>  		ranges = <
> -			0 0 fc000000 04000000
> -			3 0 fa000000 01000000
> +			0x0 0x0 0xfc000000 0x4000000
> +			0x3 0x0 0xfa000000 0x1000000

Chip selects should probably be decimal.

-Scott
