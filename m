Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49241DDF1E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:12:14 +1000 (EST)
Message-Id: <E7CE3402-A2DF-4F9A-82B4-82489FA3B3AA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090403211549.GA22860@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] cpm_uart: Disable CPM udbg when re-initing CPM uart,
	even if not the console.
Date: Mon, 6 Apr 2009 09:10:07 -0500
References: <20090403211549.GA22860@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 3, 2009, at 4:15 PM, Scott Wood wrote:

> Previously, if udbg was using the CPM uart, and the normal CPM uart  
> driver
> was enabled, but the console was directed elsewhere, udbg would not be
> stopped prior to initialization.  This resulted in udbg hanging  
> forever
> waiting for the CPM to process a descriptor.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> drivers/serial/cpm_uart/cpm_uart_core.c |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)


applied

- k
