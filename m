Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44531DDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 10:49:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5R0nGMx016357
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 20:49:16 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5R0nGqc209168
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 18:49:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5R0nFI1012820
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 18:49:15 -0600
Date: Tue, 26 Jun 2007 19:59:50 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Winiecki <stevewin@us.ibm.com>
Subject: Re: Katmai w/ DENX git - "init has generated signal 4" error
Message-ID: <20070627005949.GB11906@crusty.rchland.ibm.com>
References: <1182877959.19501.17.camel@weaponx.rchland.ibm.com>
	<OF374AD003.85F388B3-ON87257306.0075D915-85257306.0076BA68@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF374AD003.85F388B3-ON87257306.0075D915-85257306.0076BA68@us.ibm.com>
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

On Tue, Jun 26, 2007 at 05:38:31PM -0400, Stephen Winiecki wrote:
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote on 06/26/2007 01:12:38 PM:
> 
> > Signal 4 is SIGILL, which could be returned for float instructions I
> > suppose.  Try turning on CONFIG_MATH_EMULATION in your kernel config for
> > Katmai and see if the problem goes away.
> 
> Thanks Josh - that actually did the trick w/ the original distro (which 
> apparently generates some FP ops).

Good, glad it's working for you.  Performance for apps that have FP
instructions will be slower than if you had a true FPU, but that's better
than not functioning at all.

> 
> Valentine Barshak <vbarshak@ru.mvista.com> wrote on 06/26/2007 01:58:23 
> PM:
> > Looks like 440SPe entry  is missing in the arch/ppc/kernel/cputable.c
> 
> I'm using a git snapshot version of the DENX kernel - is there some effort 
> underway to start to merge this platform support into the public tree?

I don't know of anyone starting an arch/powerpc port for Katmai yet.  And it
seems that new submissions to arch/ppc are frozen.

josh
