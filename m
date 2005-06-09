Return-Path: <kylo.ginsberg@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.194])
	by ozlabs.org (Postfix) with ESMTP id 4460667B52
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 08:09:33 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so173761rne
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Jun 2005 15:09:32 -0700 (PDT)
Message-ID: <61cc712d0506091509527ee680@mail.gmail.com>
Date: Thu, 9 Jun 2005 15:09:32 -0700
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Mapping full 1 GB of memory on a Freescale Book E part
Reply-To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm running 2.6.11 on a Freescale 8555 with 1GB of DDR memory. =20
Looking in arch/ppc/mm/fsl_booke_mmu.c, I see that at most 3 TLB
entries will be used to map memory.  Since the max tlb size on
Freescale Book E is 256 MB, this caps mapped in memory at 768 MB.

I've modified fsl_booke_mmu.c to use a 4th TLB, thus mapping the full
1 GB of memory.  However, I'm new to linux memory management, so I'd
appreciate any comments as to whether there are tradeoffs or dangers
here that I am missing.

Thanks,
Kylo
