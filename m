Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4BA3DDDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 00:11:05 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7HEB1kG024466
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 10:11:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7HEApBb163120
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 08:10:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7HEApuS012297
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 08:10:51 -0600
Date: Fri, 17 Aug 2007 09:10:50 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: [PATCH] Fixup modpost warnings in head*.S for ppc32
Message-ID: <20070817091050.378379a9@weaponx.rchland.ibm.com>
In-Reply-To: <B4F8C3D2-2813-445A-BB7D-B1F855ADCF79@kernel.crashing.org>
References: <Pine.LNX.4.64.0708170847120.29396@blarg.am.freescale.net>
	<20070817090535.0586160a@weaponx.rchland.ibm.com>
	<B4F8C3D2-2813-445A-BB7D-B1F855ADCF79@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 17 Aug 2007 09:10:10 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Aug 17, 2007, at 9:05 AM, Josh Boyer wrote:
> 
> > On Fri, 17 Aug 2007 08:48:40 -0500 (CDT)
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> >> diff --git a/arch/powerpc/kernel/head_4xx.S b/arch/powerpc/kernel/ 
> >> head_4xx.S
> >> index adc7f80..a0c9151 100644
> >> --- a/arch/powerpc/kernel/head_4xx.S
> >> +++ b/arch/powerpc/kernel/head_4xx.S
> >> @@ -53,9 +53,9 @@
> >>   *
> >>   * This is all going to change RSN when we add bi_recs.......  --  
> >> Dan
> >>   */
> >> -	.text
> >> -_GLOBAL(_stext)
> >> -_GLOBAL(_start)
> >> +	.section	.text.head, "ax"
> >> +_ENTRY(_stext);
> >> +_ENTRY(_start);
> >
> > FYI, I renamed this file to head_40x.S in my current for-2.6.24
> > series.  Hopefully Paul will pull that soon.
> 
> sure, will rebase this once its ready, and hopefully Paul will have  
> your 40x support in his for-2.6.24 tree.

40x "support" isn't there yet.  Just the path renames.  But I'm in the
process of actually testing your patch on 40x as we speak with
my local patches.  And 44x for that matter.  Stay tuned :)

josh
