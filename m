Return-Path: <j.borkhuis@dutchspace.nl>
Message-ID: <46275C7A.4030903@dutchspace.nl>
Date: Thu, 19 Apr 2007 14:11:38 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: PREEMPT_RT patch on 85xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am trying to run Ingo's PREEMPT_RT patch on an MVME3100 (PPC 8540). 
But when I try to compile the kernel (version 2.6.20 with Motorola 
MVME3100 patch and patch-2.6.20-rt8) I get compile errors. I did find an 
extra patch-set for use with the powerpc architecture, but this set does 
not fix the ppc-architecture.

Is there another patch available, or did I miss some configuration 
option? Or is the PREEMPT_RT patch not (yet) available for the ppc 
architecture?

Kind regards,
    Johan Borkhuis
