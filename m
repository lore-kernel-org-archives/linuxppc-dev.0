Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F6CB67B84
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 04:57:59 +1000 (EST)
From: segher@gate.crashing.org
Message-ID: <50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
Date: Sat, 19 Aug 2006 14:10:14 -0500 (CDT)
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
To: <arnd@arndb.de>
In-Reply-To: <200608182105.45264.arnd@arndb.de>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<36A1A5C6-5269-4BDA-9F3E-A632B3A627DB@kernel.crashing.org>
	<1155924687.9659.25.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +#define INST_POPCNTB           0x7c0000f4
>> +
>
>> +       /* Emulate the popcntb (Population Count Bytes) instruction.
>> */ +       if ((instword & INST_POPCNTB) == INST_POPCNTB) {
>> +               return emulate_popcntb_inst(regs, instword);
>> +       }
>> +
>
> Is that the right check? The other similar traps check against a
> mask of 0x7c0007fe.

I hope you mean 0xfc0007fe?


Segher
