Return-Path: <BDE@teamlog.com>
Received: from me-ml2.teamlog.fr (smtp-grenoble1.teamlog.com [194.2.68.40])
	by ozlabs.org (Postfix) with ESMTP id B2DF167C8C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 22:58:05 +1000 (EST)
Subject: Re: ARCH=ppc or ARCH=powerpc
From: Benjamin Delagoutte <BDE@teamlog.com>
To: Josh Boyer <jdub@us.ibm.com>
In-Reply-To: <1156423796.5640.23.camel@zod.rchland.ibm.com>
References: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
	<1156423796.5640.23.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Aug 2006 14:58:15 +0200
Message-Id: <1156424295.19482.11.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: BDE@teamlog.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Le jeudi 24 août 2006 à 07:49 -0500, Josh Boyer a écrit :
> On Thu, 2006-08-24 at 05:38 -0700, Parav Pandit wrote:
> > ppc = 32bit.
> > powerpc= 64bit.
> > Correct me if I am wrong.
> 
> Yes, you're wrong.  Some 32 bit boards are also under arch/powerpc now.
> 
> >  
> > I am not sure why community didn't adopt the name ppc and ppc64 just
> > like ia-32 and ia64.
> 
> They did originally.
> 
> The new direction is to have everything under arch/powerpc, both 32 and
> 64 bit.  The reason arch/ppc still exists is because some 32 bit
> platforms have not been fully migrated to the requirements to be merged
> into arch/powerpc.  Namely, the code has to boot from an OpenFirmware
> like flattened device tree.  The PPC 4xx family of processors, as an
> example, does not do this yet though there is work going on to adapt it.

I'm currently working on a PPC 405 based developement card. Does it mean
I have to work using the arch/ppc tree ? 

What about the includes ? Do I have to use only include/asm-ppc or are
include/asm-powerpc necessary as well ?

> Eventually, arch/ppc will go away and all of PowerPC will be under
> arch/powerpc.  That's the goal anyway.
> 
> josh
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
