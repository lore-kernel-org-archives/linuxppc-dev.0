Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A42AADE12F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:34:45 +1000 (EST)
Message-Id: <7DA5A123-700B-4DA2-BAD0-E4E894EDD3F3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <DBDA460C-2CFC-45AF-9974-EE6433E09793@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 10:34:38 -0500
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
	<55923B54-4F55-4779-B071-CB816BD4FA99@lixom.net>
	<B9E4053C-723F-4BB2-B789-F3F18BA04C4B@kernel.crashing.org>
	<7FE83D5F-6D1C-41F2-8823-868B30A2BDE3@lixom.net>
	<E91EB0E1-DAEB-4CC5-B601-C12A5D4F2F4F@kernel.crashing.org>
	<DBDA460C-2CFC-45AF-9974-EE6433E09793@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2008, at 10:04 AM, Olof Johansson wrote:

> On Jun 17, 2008, at 9:42 AM, Kumar Gala wrote:
>
>>> But: since the cacheline is available in cputable, it can still be  
>>> used at runtime, so as long as the alignments are large enough,  
>>> stuff like the dcbz loops should still be OK (might need an audit  
>>> though to make sure there's nothing missed). With that, you could  
>>> at least still boot an E500MC kernel on E500.
>>
>> Its not as simple as that since there are assumptions about how  
>> many bytes a dcbz will clear.
>
> Ok, ppc64 already gets that info from the cputable, not from compile  
> time options. I guess ppc32 lacks that so far.

Yeah, if you look at the asm/cache.h the defines in there are used all  
over the place for ppc32 (like copy_32.S, misc_32.S)

- k
