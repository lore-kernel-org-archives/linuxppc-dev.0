Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3F2E68A1F
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 01:28:58 +1100 (EST)
In-Reply-To: <17384.30426.76075.491857@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.61.0601311746250.18350@cde-tx32-ldt329.sps.mot.com>
	<17384.30426.76075.491857@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0298A03B-4A0D-48CE-B941-EB3D0CEA9606@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix Kernel FP unavail exception for BookE
Date: Tue, 7 Feb 2006 08:28:50 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, galak@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 7, 2006, at 4:30 AM, Paul Mackerras wrote:

> Becky Bruce writes:
>
>> powerpc: Correct BookE FP unavailable exception
>
> ...
>
>> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/ 
>> kernel/head_booke.h
>
> Ummm... which tree has head_booke.h?

powerpc.git should have it.  If not this is an issue that should be  
fixed.

Becky, is this change also needed for arch/ppc?  If so can you fixup  
arch/ppc/kernel/head_booke.h and provide patch that duplicates  
head_booke.h in arch/powerpc/kernel if its not there.

- k
