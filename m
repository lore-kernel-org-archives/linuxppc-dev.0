Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2628BDDEA3
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 18:57:48 +1100 (EST)
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200801120826.53091.sr@denx.de>
References: <1199526609-12290-1-git-send-email-sr@denx.de>
	<20080111174822.GB17240@gate.ebshome.net>
	<1200089457.6896.65.camel@pasglop>  <200801120826.53091.sr@denx.de>
Content-Type: text/plain
Date: Sat, 12 Jan 2008 18:57:24 +1100
Message-Id: <1200124644.6896.99.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-01-12 at 08:26 +0100, Stefan Roese wrote:
> 
> We shouldn't make it too complicated. We can always select different
> settings 
> in the defconfig file. My thinking here is to better wast a little
> memory 
> with a potential performance improvement. Just me 0.02$

If it gets really critical, then we can move those settings to the
device-tree.

Ben.
