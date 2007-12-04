Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D322DDFB1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 09:31:46 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB4MVhEe003484
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Dec 2007 17:31:43 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB4MVh5J500476
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Dec 2007 17:31:43 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB4MVgcJ026959
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Dec 2007 17:31:43 -0500
Date: Tue, 4 Dec 2007 16:29:16 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: niklaus.giger@member.fsf.org
Subject: Re: Problem compiling sequoia using DENX kernel. Xenomai-patch
	required?
Message-ID: <20071204162916.5e9140ce@zod.rchland.ibm.com>
In-Reply-To: <200712042314.38498.niklaus.giger@member.fsf.org>
References: <20071203230816.1C502242E9@gemini.denx.de>
	<200712042314.38498.niklaus.giger@member.fsf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 4 Dec 2007 23:14:38 +0100
Niklaus Giger <niklaus.giger@member.fsf.org> wrote:

> Am Dienstag, 4. Dezember 2007 schrieb Wolfgang Denk:
> <...>
> > I'm afraid "normal" here still means arch/ppc  -  hopefully  for  not
> > long any more. Note: a matching Xenomai patch for arch/ppc will be in
> > Xenomai 2.4 when it comes out in a few days.
> Thanks a lot for your explanation. I took 
> ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-1.6-00.patch 
> from the xenomai trunk and was able to compile and boot successfully
> the yosemite board (using ARCH=ppc). Will try the sequoaia board tomorrow.
> 
> I hope that this is a good starting point to get my custom PPC440EPx board 
> into shape. I think once the arch/powerpc will work for PPC440 it should not 
> be a lot of work to port it from ppc -> powerpc.

Sequoia is already in arch/powerpc.  At least most of the base support.

josh
