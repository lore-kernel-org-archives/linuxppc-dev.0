Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7F4ADDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 00:21:35 +1100 (EST)
Message-Id: <A112398F-5B9B-4E05-976D-8B7FC932FC8B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18694.33816.996886.431170@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] powerpc: Add new CPU feature: CPU_FTR_UNALIGNED_LD_STD
Date: Tue, 28 Oct 2008 08:21:21 -0500
References: <200810272143.02144.markn@au1.ibm.com>
	<349712B7-EA3A-4BAA-9DB8-8A5FDD0AA060@kernel.crashing.org>
	<18694.33816.996886.431170@cargo.ozlabs.ibm.com>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2008, at 10:16 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> not that I have anything against this patch but is there anything we
>> can do about the CPU_FTR_ usage for one of things like this?
>
> <blinks>
>
> Can you express that a little more coherently for us, please? :)

I'm asking if we can come up with a better solution than using  
CPU_FTR_ bits for extremely specific uses like this.

- k
