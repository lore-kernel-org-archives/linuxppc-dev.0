Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4C74475B9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 03:17:30 +1100 (EST)
Message-Id: <4DD3CDBC-94D0-4B7C-B157-5D4662757952@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081209092649.1d262327@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/5] powerpc: booke: Don't hard-code size of struct tlbcam
Date: Wed, 7 Jan 2009 10:17:07 -0600
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
	<20081209092649.1d262327@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 9, 2008, at 8:26 AM, Josh Boyer wrote:

> On Mon,  8 Dec 2008 19:34:55 -0800
> Trent Piepho <tpiepho@freescale.com> wrote:
>
>> Some assembly code in head_fsl_booke.S hard-coded the size of  
>> struct tlbcam
>> to 20 when it indexed the TLBCAM table.  Anyone changing the size  
>> of struct
>> tlbcam would not know to expect that.
>>
>> The kernel already has a system to get the size of C structures into
>> assembly language files, asm-offsets, so let's use it.
>>
>> The definition of the struct gets moved to a header, so that asm- 
>> offsets.c
>> can include it.
>
> I don't mean to be overly picky, but your patch subjects and changelog
> descriptions are a bit wrong.  This series pertains to FSL BookE  
> chips,
> not BookE in general.  There are other variants of BookE, such as 4xx.
>
> If you could keep that in mind for future revisions, I'd appreciate
> it.  Something like:
>
> [PATCH] powerpc/fsl-booke:
>
> or something similar would be a bit more correct.  Unless you really
> are changing something global to all BookE processors (which is sort  
> of
> rare at the moment).

I fixed this in the actually commit ;)

- k
