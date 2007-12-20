Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED468DDE98
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 03:36:55 +1100 (EST)
Date: Thu, 20 Dec 2007 10:36:43 -0600
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: More patches added to for-2.6.25 and master branches of
	powerpc.git
Message-ID: <20071220163643.GA4386@loki.buserror.net>
References: <18282.19253.485799.233476@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18282.19253.485799.233476@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 10:00:05PM +1100, Paul Mackerras wrote:
> Scott Wood (5):
>       [POWERPC] 8xx: Convert mpc866ads to the new device binding.
>       [POWERPC] 83xx: mpc834x_mds: Fix whitespace and call of_platform_bus_probe().
>       [POWERPC] 83xx: mpc8313erdb: Fix whitespace.
>       [POWERPC] wrapper: Rename offset in offset_devp()
>       [POWERPC] wrapper: Treat NULL as root node in devp_offset; add devp_offset_find()

How about this power management patchset?
http://patchwork.ozlabs.org/linuxppc/patch?id=15502

-Scott
