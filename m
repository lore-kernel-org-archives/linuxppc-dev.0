Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id B2F36DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 01:04:40 +1000 (EST)
Message-Id: <DBDA460C-2CFC-45AF-9974-EE6433E09793@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <E91EB0E1-DAEB-4CC5-B601-C12A5D4F2F4F@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 10:04:31 -0500
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
	<55923B54-4F55-4779-B071-CB816BD4FA99@lixom.net>
	<B9E4053C-723F-4BB2-B789-F3F18BA04C4B@kernel.crashing.org>
	<7FE83D5F-6D1C-41F2-8823-868B30A2BDE3@lixom.net>
	<E91EB0E1-DAEB-4CC5-B601-C12A5D4F2F4F@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 17, 2008, at 9:42 AM, Kumar Gala wrote:

>> But: since the cacheline is available in cputable, it can still be  
>> used at runtime, so as long as the alignments are large enough,  
>> stuff like the dcbz loops should still be OK (might need an audit  
>> though to make sure there's nothing missed). With that, you could  
>> at least still boot an E500MC kernel on E500.
>
> Its not as simple as that since there are assumptions about how many  
> bytes a dcbz will clear.

Ok, ppc64 already gets that info from the cputable, not from compile  
time options. I guess ppc32 lacks that so far.


-Olof
