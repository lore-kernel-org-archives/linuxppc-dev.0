Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 19ADEDDE27
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 04:53:31 +1100 (EST)
Message-ID: <45A91C92.4030504@am.sony.com>
Date: Sat, 13 Jan 2007 09:53:22 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 7/19] powerpc: interfaces to the hypervisor of Celleb
References: <200701120100.l0C10ktW025821@toshiba.co.jp>	<20070113124638.GA13493@krispykreme>
	<06ebc2a1b06cafb9aaa3bcf8407db1fe@kernel.crashing.org>
In-Reply-To: <06ebc2a1b06cafb9aaa3bcf8407db1fe@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> +#define	HVSC	.long	0x44000022
>>
>> Could you pick this up from the define in include/asm-powerpc instead?
> 
> Or just write "sc 1", everyone should have new enough binutils
> by now.

The option to 'sc' came in binutils-2.17, but I from what I understand, debian
stable doesn't have it, so I used a similar construction for ps3.

-Geoff
