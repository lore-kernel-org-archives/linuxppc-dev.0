Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D767DDE2F
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 22:39:56 +1000 (EST)
In-Reply-To: <46F88896.50706@au1.ibm.com>
References: <46F88896.50706@au1.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
Date: Tue, 25 Sep 2007 07:39:14 -0500
To: Mark Nelson <markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2007, at 11:03 PM, Mark Nelson wrote:

> Update dump_task_altivec() (that has so far never been put to use)
> so that it dumps the Altivec/VMX registers (VR[0] - VR[31], VSCR
> and VRSAVE) in the same format as the ptrace get_vrregs() and add
> the appropriate glue typedefs and #defines to
> include/asm-powerpc/elf.h for it to work.

Is there some way to tell if the core dump has altivec registers  
state in it?

I'm wondering how we distinguish a core dump w/altivec state vs one  
with SPE state.

- k
