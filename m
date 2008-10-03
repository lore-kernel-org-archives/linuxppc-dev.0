Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 343EFDDF08
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 07:57:48 +1000 (EST)
Message-ID: <48E69551.90300@freescale.com>
Date: Fri, 03 Oct 2008 16:57:37 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: make Freescale QE support a selectable Kconfig
	option
References: <1223050450-32234-1-git-send-email-timur@freescale.com>
	<398EE654-3AC7-4939-91DC-49E9520D2B18@kernel.crashing.org>
In-Reply-To: <398EE654-3AC7-4939-91DC-49E9520D2B18@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> applied

I have a few other patches that I've sent you over the past couple weeks that
you haven't applied:

powerpc: fix conflict with Elo DMA driver in MPC8610 device tree
powerpc: remove CHRP and PMAC support from defconfigs, fix Kconfigs
powerpc: remove support for bootmem-allocated memory for the DIU driver

-- 
Timur Tabi
Linux kernel developer at Freescale
