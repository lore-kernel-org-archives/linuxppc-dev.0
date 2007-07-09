Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97007DDEC9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 05:56:31 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l69Jp3JI030107
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:51:03 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l69JuOSA207300
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:56:25 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l69JuOSg008022
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:56:24 -0600
Date: Mon, 9 Jul 2007 14:56:23 -0500
To: Marc Leeman <marc.leeman@gmail.com>
Subject: Re: 2.4/2.6/ppc/powerpc/8245/8347e
Message-ID: <20070709195623.GK4457@austin.ibm.com>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
	<20070621171340.GS5417@chiana.homelinux.org>
	<20070628180632.GA2660@chiana.homelinux.org>
	<20070629145936.GL2660@chiana.homelinux.org>
	<20070709154723.GD2660@chiana.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070709154723.GD2660@chiana.homelinux.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2007 at 05:47:23PM +0200, Marc Leeman wrote:
> 
> Disabling this replaces the advanced SLAB allocator and
> kmalloc support with the drastically simpler SLOB allocator.
> SLOB is more space efficient but does not scale well and is
> more susceptible to fragmentation. 
> --------
> 
> I was expecting a lower DMM performance but wasn't expecting such a
> drain on kernel/network load.

OK, to be clear: you seem to be saying that using the SLOB instead
of the SLAB allocator results in such terrible memory fragmentation
that network performance is degraded by large factors (2x or 5x or
something like that, if I remember your earlier emails). Is that right?

I thought I heard about some memory-defrag patches being posted.  
What happens if these are used together with SLOB? Does one regain the
lost performance? Perhaps maybe one gets even better performance?

--linas
