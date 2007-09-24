Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51935DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 01:58:34 +1000 (EST)
Message-ID: <46F7DE85.7000401@freescale.com>
Date: Mon, 24 Sep 2007 10:57:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH4/4] [POWERPC] Fix cpm_uart driver
References: <46F6C9DC.90008@scram.de>
In-Reply-To: <46F6C9DC.90008@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> 
> In cpm_uart_core, functions cpm_uart_init_bd and cpm_uart_init_scc
> an offset into DP RAM is calculated by substracting a physical
> memory constant from an virtual address. This patch fixes the
> problem by converting the virtual address into a physical
> first.

Huh?  DPRAM_BASE is a virtual address.  With this patch, you'd be 
subtracting a virtual address from a physical address.

-Scott
