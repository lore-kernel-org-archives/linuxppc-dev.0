Return-Path: <jwboyer@linux.vnet.ibm.com>
Subject: Re: PREEMPT_RT patch on 85xx
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Johan Borkhuis <j.borkhuis@dutchspace.nl>
In-Reply-To: <46275C7A.4030903@dutchspace.nl>
References: <46275C7A.4030903@dutchspace.nl>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 07:26:46 -0500
Message-Id: <1176985606.3877.12.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-19 at 14:11 +0200, Johan Borkhuis wrote:
> Hello,
> 
> I am trying to run Ingo's PREEMPT_RT patch on an MVME3100 (PPC 8540). 
> But when I try to compile the kernel (version 2.6.20 with Motorola 
> MVME3100 patch and patch-2.6.20-rt8) I get compile errors. I did find an 
> extra patch-set for use with the powerpc architecture, but this set does 
> not fix the ppc-architecture.
> 
> Is there another patch available, or did I miss some configuration 
> option? Or is the PREEMPT_RT patch not (yet) available for the ppc 
> architecture?

arch/ppc is dying a slow death and is being replaced by arch/powerpc.
This is likely why there is no ppc "backport".

josh
