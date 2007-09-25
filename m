Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 172D5DDDE4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 03:58:46 +1000 (EST)
Message-ID: <46F94CBA.2060901@genesi-usa.com>
Date: Tue, 25 Sep 2007 19:00:26 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
References: <46F88896.50706@au1.ibm.com>
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
In-Reply-To: <E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kumar Gala wrote:
> On Sep 24, 2007, at 11:03 PM, Mark Nelson wrote:
> 
>> Update dump_task_altivec() (that has so far never been put to use)
>> so that it dumps the Altivec/VMX registers (VR[0] - VR[31], VSCR
>> and VRSAVE) in the same format as the ptrace get_vrregs() and add
>> the appropriate glue typedefs and #defines to
>> include/asm-powerpc/elf.h for it to work.
> 
> Is there some way to tell if the core dump has altivec registers  
> state in it?
> 
> I'm wondering how we distinguish a core dump w/altivec state vs one  
> with SPE state.

Sheer number of registers saved?

Why not put the PVR in core dumps that'd make it all easier..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
