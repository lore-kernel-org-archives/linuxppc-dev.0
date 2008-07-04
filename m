Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: More commits added to powerpc.git master and powerpc-next
	branches
In-reply-to: <18540.41013.722932.726273@cargo.ozlabs.ibm.com> 
References: <18540.41013.722932.726273@cargo.ozlabs.ibm.com>
Date: Fri, 04 Jul 2008 10:17:39 +1000
Message-ID: <11064.1215130659@neuling.org>
Cc: linuxppc-dev@ozlabs.org, sonnyrao@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Paul.
> 
> Kumar Gala (2):
>       powerpc: Fix building of feature-fixup tests on ppc32
>       powerpc: Fixup lwsync at runtime
> 
> Michael Neuling (3):
>       powerpc: Fix compile warning in init_thread
>       powerpc: Clean up copy_to/from_user for vsx and fpr
>       powerpc: Remove old dump_task_* functions
> 
> Nathan Fontenot (5):
>       powerpc/pseries: Allow phandle to be specified in formats other than de
cimal
>       powerpc/pseries: Use base address to derive starting page frame number
>       powerpc/pseries: Update the device tree correctly for drconf memory add
/remove
>       powerpc/pseries: Split code into helper routines for drconf memory
>       powerpc/pseries: Update numa association of hotplug memory add for drco
nf memory
> 
> Tony Breeds (1):
>       powerpc: Fix building of arch/powerpc/mm/mem.o when MEMORY_HOTPLUG=y an
d SPARSEMEM=n

Paulus,

Can you apply Sonny's BSR patch?  

http://patchwork.ozlabs.org/linuxppc/patch?q=sonny&id=19036

Mikey
