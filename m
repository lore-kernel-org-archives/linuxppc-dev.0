Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E3281B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 21:13:27 +1000 (EST)
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57F83DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 21:13:26 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n62B8NDI003744
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2009 07:08:23 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n62BDKZc232766
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2009 07:13:20 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n62BDKig029503
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2009 07:13:20 -0400
Date: Thu, 2 Jul 2009 07:12:46 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Preemption question (4xx related)
Message-ID: <20090702111246.GG6189@zod.rchland.ibm.com>
References: <24271342.post@talk.nabble.com> <1246486393.14483.14.camel@pasglop>
	<20090702001450.GF6189@zod.rchland.ibm.com>
	<1246519992.7551.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246519992.7551.1.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 02, 2009 at 05:33:12PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2009-07-01 at 20:14 -0400, Josh Boyer wrote:
>
>> I've toyed with that idea myself.  I keep coming back to the fact that you need
>> a workload that would really leverage it, and I don't have one at the moment.
>
>To some extent that's true but just turning full preemption including
>kernel side with all the associated debug bits and lockdep should make a
>whole bunch of things show up even with ordinary workloads.

I can look at doing that for ppc44x_defconfig.  I'll be honest and say I don't
expect it to go well, particularly with lockdep :).

>For 440 tend to boot an ubuntu distro off NFS root with all X & DRI 3D
>etc... and then run compiz :-)

Yes.  Because that's a totally realistic workload for a 440.  I'm surprised you
don't have a p595 machine acting as your home router too!  ;)

josh
