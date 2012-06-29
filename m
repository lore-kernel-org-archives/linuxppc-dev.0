Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4FFA7B7018
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 06:01:05 +1000 (EST)
Subject: Re: powerpc/85xx: p2020rdb - move the NAND address.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120509195307.GA25255@linutronix.de>
Date: Fri, 29 Jun 2012 15:01:01 -0500
Message-Id: <C1F76886-9E5C-4DA5-B610-67371EA5B236@kernel.crashing.org>
References: <E9CCADB024EDCD44A9C1083605680C42B9053302@ES05CO.wgti.net>
 <4F740E98.50104@linutronix.de>
 <9460468D-281C-4960-839A-F8435638DE4B@kernel.crashing.org>
 <4F75BD6B.30609@linutronix.de>
 <926BF56B-AA5C-443B-BD52-6844518810DB@kernel.crashing.org>
 <20120509195307.GA25255@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bryan Hundven <Bryan.Hundven@watchguard.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 9, 2012, at 2:53 PM, Sebastian Andrzej Siewior wrote:

> * Kumar Gala | 2012-03-31 09:48:18 [-0500]:
> 
> Sorry for the delay Kumar, I though I allready done it.
> 
>> Yes, please do.
> Here it comes.
> 
>> From 5b3e09992615e5670fa8e432e50424466fa9ca1a Mon Sep 17 00:00:00 2001
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Wed, 9 May 2012 21:48:42 +0200
> Subject: [PATCH] Revert "powerpc/85xx: p2020rdb - move the NAND address."
> 
> This reverts commit 0c00f65653389a408dfbbee7578e671664eea26a.
> The initial commit was my fault. There are two boards out there:
> P2020RDB and P2020RDB-PC. I wasn't aware of that and assumed that I have
> a RDB board in front of me while I the RDB-PC. This patch makes it work
> for the RDB-PC variant and breaks it for the RDB. Now there is a device
> tree file available for the RDB-PC which was not there earlier. So with
> this revert, everything gets back to normal :)
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/boot/dts/p2020rdb.dts |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

applied

- k
