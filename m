Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18356DDEDB
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 05:56:39 +1000 (EST)
Message-Id: <F52FE3BF-FE92-44BF-B106-0A8B6DF4C0E1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4858127F.10601@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 14:55:59 -0500
References: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>	<20080617162309.GA3217@loki.buserror.net>	<2FC90D95-762E-41D7-AD4E-64362B624BF8@kernel.crashing.org>	<485801A7.3090309@freescale.com>	<C5C81740-FEF8-42CA-80C2-A729238BED2B@kernel.crashing.org>
	<485811DD.50106@freescale.com> <4858127F.10601@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 2:37 PM, Scott Wood wrote:

> Scott Wood wrote:
>> Kumar Gala wrote:
>>> Also, there is a direction that does work.  You can run an e500v2  
>>> kernel on an e500mc.  Its just going the other way around that can  
>>> be an issue.
>> Actually, wouldn't the kernel need to set HID0[DCBZ32] for an  
>> e500v2 kernel to run on e500mc?
>
> Grr, I meant L1CSR0[DCBZ32].

You are correct we would need to do that.

- k
