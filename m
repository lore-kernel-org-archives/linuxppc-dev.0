Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1645DE027
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 04:24:55 +1100 (EST)
Message-ID: <478654F1.2060305@freescale.com>
Date: Thu, 10 Jan 2008 11:25:05 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix handling of memreserve if the range lands
	in highmem
References: <Pine.LNX.4.64.0801091127400.8069@blarg.am.freescale.net>
	<20080109185349.GC4337@loki.buserror.net>
	<3B831CF0-E978-42E7-BA26-7598BC27A5F6@kernel.crashing.org>
	<478520E4.1050204@freescale.com>
	<9536E0AC-E4D2-4E86-8DC6-F40A322FC817@kernel.crashing.org>
	<478525E7.3060106@freescale.com>
	<354E8B44-78B4-49DF-8DCF-5E70BB982E86@kernel.crashing.org>
In-Reply-To: <354E8B44-78B4-49DF-8DCF-5E70BB982E86@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Jan 9, 2008, at 1:52 PM, Scott Wood wrote:
> 
>> Kumar Gala wrote:
>>> I'm thinking I'll add something like:
>>>                if (addr < total_lowmem)
>>>                        reserve_bootmem(lmb.reserved.region[i].base,
>>>                                        lmb_size_bytes(&lmb.reserved, 
>>> i));
>>> +               else if (lmb.reserved.region[i].base > total_lowmem) {
>>
>> less than, surely?
> 
> damn, why didn't I see your email before a spent 20 minutes debugging 
> this ;)

Because, as happens all too often lately, Freescale's mail servers 
needed to chew on it for an hour and a half before sending it on. :-P

-Scott
