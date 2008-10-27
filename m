Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20837DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 00:45:01 +1100 (EST)
Message-Id: <349712B7-EA3A-4BAA-9DB8-8A5FDD0AA060@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <200810272143.02144.markn@au1.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] powerpc: Add new CPU feature: CPU_FTR_UNALIGNED_LD_STD
Date: Mon, 27 Oct 2008 08:44:48 -0500
References: <200810272143.02144.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2008, at 5:43 AM, Mark Nelson wrote:

> Add a new CPU feature bit, CPU_FTR_UNALIGNED_LD_STD, to be added
> to the 64bit powerpc chips that can do unaligned load double and
> store double (and not take a performance hit from it).
>
> This is added to Power6 and Cell and will be used in an upcoming
> patch to do the alignment in memcpy() only on CPUs that require
> it.
>
> Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> ---
> arch/powerpc/include/asm/cputable.h |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

not that I have anything against this patch but is there anything we  
can do about the CPU_FTR_ usage for one of things like this?

- k
