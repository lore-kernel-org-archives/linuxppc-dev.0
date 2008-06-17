Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B55ADE5F2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 05:55:56 +1000 (EST)
Message-Id: <28C30C45-9F42-4097-BEB2-6015296AC9CE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48580FCF.5020604@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 14:55:46 -0500
References: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
	<20080617162309.GA3217@loki.buserror.net>
	<2FC90D95-762E-41D7-AD4E-64362B624BF8@kernel.crashing.org>
	<485801A7.3090309@freescale.com>
	<C5C81740-FEF8-42CA-80C2-A729238BED2B@kernel.crashing.org>
	<48580FCF.5020604@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 2:26 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> Also, there is a direction that does work.  You can run an e500v2  
>> kernel on an e500mc.  Its just going the other way around that can  
>> be an issue.
>
> Maybe have a "choice" config option for minimum supported e500  
> version, with higher settings being better optimized but  
> incompatible with older hardware?  This would be similar to how x86  
> does it.

For now I'm going to stick with what we got.  Hopefully we can work  
through the issues and have a single kernel support v1/v2/mc with all  
the features.

- k
