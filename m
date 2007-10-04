Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59596DDE22
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 08:04:03 +1000 (EST)
Message-ID: <4705634A.9070800@freescale.com>
Date: Thu, 04 Oct 2007 17:03:54 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] update immap_86xx.h for the 8610
References: <11913604331348-git-send-email-timur@freescale.com>
In-Reply-To: <11913604331348-git-send-email-timur@freescale.com>
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

Kumar, can you pull this patch into your 2.6.24 tree?  It's needed for the 8610.

Timur Tabi wrote:
> Update the definition of the global utilities structure (ccsr_guts) in
> immap_86xx.h and add some related macros for the Freescale 8610 SOC.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> This patch is for 2.6.24.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
