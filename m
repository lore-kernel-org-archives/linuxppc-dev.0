Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7ECBB6F7F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 05:39:05 +1000 (EST)
Subject: Re: [PATCH] powerpc/book3e: Fix CPU feature handling on 64-bit e5500
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110406130257.2d31beaa@schlenkerla.am.freescale.net>
Date: Thu, 7 Apr 2011 14:38:57 -0500
Message-Id: <7597043B-4C16-47F7-8AF7-111A5815545E@kernel.crashing.org>
References: <1302092943-10586-1-git-send-email-galak@kernel.crashing.org>
	<20110406130257.2d31beaa@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 6, 2011, at 1:02 PM, Scott Wood wrote:

> On Wed, 6 Apr 2011 07:29:03 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>=20
>> diff --git a/arch/powerpc/include/asm/cputable.h =
b/arch/powerpc/include/asm/cputable.h
>> index be3cdf9..9028a9e 100644
>> --- a/arch/powerpc/include/asm/cputable.h
>> +++ b/arch/powerpc/include/asm/cputable.h
>> @@ -386,6 +386,10 @@ extern const char *powerpc_base_platform;
>> 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
>> 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
>> 	    CPU_FTR_DBELL)
>> +#define CPU_FTRS_E5500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB =
| \
>> +	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
>=20
> E5500 cannot doze or nap in the way meant by existing code (MSR[WE]).

Should I drop them for e500mc as well?

- k=
