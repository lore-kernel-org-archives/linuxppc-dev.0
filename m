Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC1B1DDF6B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 03:56:19 +1100 (EST)
Message-ID: <47EBD1AB.1070908@freescale.com>
Date: Thu, 27 Mar 2008 11:56:11 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Enable CONFIG_FORCE_MAX_ZONEORDER for all PowerPC, and
	make selectable
References: <1206480932-30190-1-git-send-email-timur@freescale.com>
In-Reply-To: <1206480932-30190-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> This patch enables the FORCE_MAX_ZONEORDER Kconfig option for all PowerPC
> systems.  Previously, it was enabled only for 64-bit systems.  We also make
> the option selectable from the menu, so that the user can specify different
> values.  This is useful for 32-bit systems that need to allocate more than
> 4MB of physically contiguous memory.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

If there are no objections, I'd like this patch picked up for 2.6.26.

-- 
Timur Tabi
Linux kernel developer at Freescale
