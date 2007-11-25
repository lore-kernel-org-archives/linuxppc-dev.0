Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4700DDECB
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 02:41:21 +1100 (EST)
Message-ID: <47499711.2020409@freescale.com>
Date: Sun, 25 Nov 2007 09:38:57 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH revised 3/4] powerpc: Add EXPORT_SYMBOL_GPL for symbols
	required by fs_enet and cpm_uart
References: <4745BDC9.3080602@scram.de>
In-Reply-To: <4745BDC9.3080602@scram.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> fs_enet and cpm_uart need symbols from commproc.c (for CPM1) or
> cpm2_common.c. Add EXPORT_SYMBOL_GPL for cpmp, cpm_setbrg and cpm2_immr,
> so the drivers can be compiled as modules.

Maybe this is a stupid question, but why did you choose EXPORT_SYMBOL_GPL and 
not EXPORT_SYMBOL?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
