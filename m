Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC5B4DDE22
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:12:10 +1000 (EST)
Message-Id: <6B689686-EA70-4EC4-AFDC-31D96EEF30B0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090403204844.GA20017@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] cpm_uart: Initialize port.dev before it's used.
Date: Mon, 6 Apr 2009 09:09:59 -0500
References: <20090403204844.GA20017@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2009, at 3:48 PM, Scott Wood wrote:

> Previously, this caused NULL to sometimes be passed as a device
> to the DMA code.  With recent DMA changes, that now causes a BUG().
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This is a regression triggered by DMA changes; please apply for  
> 2.6.30.

applied

- k
