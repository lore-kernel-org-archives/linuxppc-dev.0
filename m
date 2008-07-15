Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8EC9EDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jul 2008 08:12:11 +1000 (EST)
Message-Id: <CF70FC2C-6837-4D49-A4C7-B6735BF33787@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: selvamuthukumar v <v.selvamuthukumar@gmail.com>
In-Reply-To: <790896390807140514r6074ec7j6d3eaf38787e3444@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: MPC8313 ERDB has proper interrupt mapping for TSEC?
Date: Tue, 15 Jul 2008 17:11:59 -0500
References: <790896390807140514r6074ec7j6d3eaf38787e3444@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 14, 2008, at 7:14 AM, selvamuthukumar v wrote:

> From, arch/powerpc/boot/dts/mpc8313erdb.dts,
>
> 212                 enet0: ethernet@24000 {
>                                   .
>                                   .
> 219                         interrupts = <37 0x8 36 0x8 35 0x8>;
>                                   .
>                                   .
> 222                 };
> 223
> 224                 enet1: ethernet@25000 {
>                                   .
>                                   .
> 231                         interrupts = <34 0x8 33 0x8 32 0x8>;
>                                   .
> 234                 };
> 235
>
> But as per 8313 Reference manual interrups 32, 33, 34 are for
> TSEC1@24000 and 35, 36, 37 are for TSEC2@25000. Any idea why interrupt
> numbers are swapped for enet0 and enet1?

I believe different revisions of the part had different mappings.

- k
