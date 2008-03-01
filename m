Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4398DDE1D
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 08:34:48 +1100 (EST)
Subject: Re: [PATCH 3/2][NEWEMAC] Use status property for unused/unwired EMACs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080301084140.7abc703e@zod.rchland.ibm.com>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301084140.7abc703e@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sun, 02 Mar 2008 08:33:15 +1100
Message-Id: <1204407195.15052.462.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-03-01 at 08:41 -0600, Josh Boyer wrote:
> Convert ibm_newemac to use the of_device_is_available function when checking
> for unused/unwired EMACs.  We leave the current check for an "unused" property
> to maintain backwards compatibility for older device trees.  Newer device
> trees should simply use the standard "status" property in the EMAC node.
> 
> The taishan DTS file is updated to reflect this.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

I don't think any other DTS than Taishan uses "unused" so we may be able
to get rid of that backward compat check. I think the Cell DT just
ommits EMACs when they are unused.

Ben.
