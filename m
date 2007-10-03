Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 8F400DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 07:45:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] PPC 85xx failure with odd memory sizes and CONFIG_HIGHMEM
Date: Wed, 3 Oct 2007 16:45:02 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B037591FD@ismail.innsys.innovsys.com>
In-Reply-To: <0B763FCF-9EFD-48E5-B2D9-53EAB0396522@kernel.crashing.org>
References: <20071003190140.GA19169@xyzzy.farnsworth.org>
	<DCEAAC0833DD314AB0B58112AD99B93B0371EFE9@ismail.innsys.innovsys.com>
	<0B763FCF-9EFD-48E5-B2D9-53EAB0396522@kernel.crashing.org>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
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

> From: Kumar Gala
> The code would have to change to allow for 1G of lowmem.
> Max lowmem with KERNELBASE @ 0xc000_0000 is 768M.

Which is why I asked. On 82xx it is supported without a codechange by
setting KERNELBASE to 0xa000_0000 in Kconfig menu (and also changing
start of virtual mem, also done by config option).
