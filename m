Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7FB7BDDE16
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 05:34:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] PPC 85xx failure with odd memory sizes and CONFIG_HIGHMEM
Date: Wed, 3 Oct 2007 14:34:42 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0371EFE9@ismail.innsys.innovsys.com>
In-Reply-To: <20071003190140.GA19169@xyzzy.farnsworth.org>
References: <20071003190140.GA19169@xyzzy.farnsworth.org>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Dale Farnsworth" <dale@farnsworth.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
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

> From: Dale Farnsworth
>=20
> The CONFIG_FSL_BOOKE mmu setup code fails when CONFIG_HIGHMEM=3Dy
> and the 3 fixed TLB entries cannot exactly map the lowmem size.
> Each TLB entry can map 4MB, 16MB, 64MB or 256MB, so the failure
> is observed when the kernel lowmem size is not equal to the
> sum of up to 3 of those values.

Does this mean you cannot run 1G of lowmem on a 85xx?

On 82xx I run 1G of lowmem, and when we finaly upgrade our product to a
85xx something, Iw was planning on doing the same.

(For those interested:
To run 1G lowmwm on 82xx (at least under arch/ppc)
CONFIG_ADVANCED_OPTIONS=3Dy
CONFIG_HIGHMEM_START=3D0xfe000000
CONFIG_LOWMEM_SIZE_BOOL=3Dy
CONFIG_LOWMEM_SIZE=3D0x40000000
CONFIG_KERNEL_START_BOOL=3Dy
CONFIG_KERNEL_START=3D0xa0000000
