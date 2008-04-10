Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1ABEFDE3B5
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 22:29:11 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200804101359.32095.sr@denx.de>
References: <1207149149-17107-1-git-send-email-sr@denx.de>
	<200804101221.43154.sr@denx.de> <1207823735.6958.7.camel@pasglop>
	<200804101359.32095.sr@denx.de>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 22:23:02 +1000
Message-Id: <1207830182.6958.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-10 at 13:59 +0200, Stefan Roese wrote:
> Understood. But for this "dynamic" root-complex/endpoint configuration as 
> implemented with the current version of the patch, I can't change the PCIe 
> node in the dts from root-complex mode to endpoint mode, since I would loose 
> root-complex functionality. Perhaps I'm missing something here.

Well, I would expect the firmware (ie. uboot) to provide the right
device-node type...

Ben.
