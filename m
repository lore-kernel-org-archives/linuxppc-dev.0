Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 89BC6DE0CC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:38:24 +1100 (EST)
Date: Mon, 17 Mar 2008 17:38:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [Patch] 8xx: MGSUVD support
Message-ID: <20080317223821.GA3622@loki.buserror.net>
References: <47D3B44D.8070909@denx.de>
	<20080309195914.69d51e68@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080309195914.69d51e68@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 09, 2008 at 07:59:14PM +0300, Vitaly Bordug wrote:
> I would like all the comments to be consistent C style (because that's it
> for the most other dts'es).

$ fgrep -rI // arch/powerpc/boot/dts/ | wc -l
539

-Scott
