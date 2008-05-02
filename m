Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D13ADDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 14:06:52 +1000 (EST)
Message-Id: <056A4D90-9815-4987-9CCF-EE8A6C009FD1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <bgill@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0805011814110.8816@monty.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Squash build warning for print of resource_size_t in
	fsl_soc.c
Date: Thu, 1 May 2008 23:06:42 -0500
References: <Pine.LNX.4.64.0805011814110.8816@monty.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2008, at 6:15 PM, Becky Bruce wrote:

>
> When resource_size_t is larger than an int, the current code
> generates a build warning.  Kill it.
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied.

- k
