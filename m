Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58408DE075
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 02:42:49 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9BGgfcf028826
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 12:42:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9BGge0o387532
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 10:42:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9BGgeJG022973
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 10:42:40 -0600
Subject: Re: [PATCH 4/4 v2] [POWERPC] Kilauea defconfig file
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20071011153700.6E2272486E@gemini.denx.de>
References: <20071011153700.6E2272486E@gemini.denx.de>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 11:39:42 -0500
Message-Id: <1192120782.5534.125.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-11 at 17:37 +0200, Wolfgang Denk wrote:
> Hallo Stefan,
> 
> In message <200710111531.13022.sr@denx.de> you wrote:
> > 
> > > If not, do you want this set by default so 
> > > floating point instructions work?
> 
> No, we use soft-float on all such systems which is much faster.
> 
> > I just checked some existing arch/ppc defconfig files (and arch/powerpc too). 
> > Most if not all have MATH_EMULATION not set. Even on those PPC's without FPU. 
> > I assume we see no problems since soft-float is used while compiling.
> > 
> > Anyways, I'll change this and resubmit.
> 
> No, please leave as is.

It's fine either way with me.  It was just a question since not all
distributions compile with soft-float.

josh
