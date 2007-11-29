Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 1D4DEDDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 06:41:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: The question about the high memory support on MPC8360?
Date: Thu, 29 Nov 2007 13:41:21 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03AE4745@ismail.innsys.innovsys.com>
In-Reply-To: <f87675ee0711290459r20aa606ak7b3be9d3b0a8ec1c@mail.gmail.com>
References: <396305910.05464@tsinghua.org.cn> <474E6A58.2070200@gdatech.co.in>
	<f87675ee0711290459r20aa606ak7b3be9d3b0a8ec1c@mail.gmail.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "robert lazarski" <robertlazarski@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: robert lazarski
> Sent: Thursday, November 29, 2007 7:00 AM
> Subject: Re: The question about the high memory support on MPC8360?
> I also have a requirement to use more than 768MB and 0x30000000. I
> have other problems at the moment, so I haven't tested this completely
> yet. My limited understanding, though, is that to use more than 768MB
> you have to change your kernel configuration, including shifting the
> kernel start address. This is what I plan on testing for 1GB when I
> have time:
>=20
> CONFIG_ADVANCED_OPTIONS=3Dy
> CONFIG_LOWMEM_SIZE_BOOL=3Dy
> CONFIG_LOWMEM_SIZE=3D0x40000000
> CONFIG_KERNEL_START_BOOL=3Dy
> CONFIG_KERNEL_START=3D0xa0000000
> # CONFIG_CONSISTENT_START_BOOL is not set
> # CONFIG_CONSISTENT_SIZE_BOOL is not set
> # CONFIG_BOOT_LOAD_BOOL is not set
>=20
> If that works for current kernels, please respond to the list ;-) .

This is how I do 1G of mem on a /arch/ppc kernel. A short while (couple
of weeks ago) I commented about thei s on a thread about setting up the
TLB handlers on arch/powerpc, and asked if this was going to be possible
to do, and basically got a resouding NO as answer.

WHich means I'll be sticking to arch/ppc for a while yet.
It would be nice to have this also working on arch/powerpc though.
