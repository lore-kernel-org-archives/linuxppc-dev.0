Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32CABB6F72
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 06:43:51 +1000 (EST)
Message-ID: <4E5FEE40.7080901@freescale.com>
Date: Thu, 1 Sep 2011 15:42:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/85xx: Rename PowerPC core nodes to match
	other	e500mc based .dts
References: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2011 02:26 PM, Kumar Gala wrote:
> The P4080 silicon device tree was using PowerPC,4080 while the other
> e500mc based SoCs used PowerPC,e500mc.  Use the core name to be
> consistent going forward.

Why are we not using the generic names recommendation?

Is the "PowerPC" vendor string still appropriate here, or should we use
"fsl"?

-Scott
