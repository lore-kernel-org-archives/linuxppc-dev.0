Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id CDA0CDDDF8
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 23:24:06 +1100 (EST)
Message-ID: <47305CDC.4050808@semihalf.com>
Date: Tue, 06 Nov 2007 13:23:56 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 05/12] [POWERPC] Export mpc52xx_map_node() routine
	symbol
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>	<20071103235240.31906.93311.stgit@hekate.izotz.org>
	<20071104150920.d0eac1ef.sfr@canb.auug.org.au>
In-Reply-To: <20071104150920.d0eac1ef.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Stephan,

Stephen Rothwell wrote:
> 
> On Sun, 04 Nov 2007 00:52:40 +0100 Marian Balakowicz <m8@semihalf.com> wrote:
>> -static void __iomem *
>> +void __iomem *
>>  mpc52xx_map_node(struct device_node *ofn)
>>  {
>>  	const u32 *regaddr_p;
>> @@ -48,6 +48,8 @@ mpc52xx_map_node(struct device_node *ofn)
>>  	return ioremap((u32)regaddr64, (u32)size64);
>>  }
>>  
>> +EXPORT_SYMBOL(mpc52xx_map_node);
>> +
> 
> We generally don't leave a blank line between a function an its
> EXPORT_SYMBOL().

Will fix that.

> Also, any reason not to use EXPORT_SYMBOL_GPL?

No, no particular reason, I used EXPORT_SYMBOL because it's used for
exporting symbols in this file. But that's good point, I'll switch  to
EXPORT_SYMBOL_GPL and I guess it would be nice to convert other
EXPORT_SYMBOL to EXPORT_SYMBOL_GPL as well, but that would be a
separate patch.

Cheers,
m.
