Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2F936B710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 10:34:43 +1000 (EST)
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76329DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 10:34:42 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n630Nn4T008730
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2009 20:23:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n630YcXk253910
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2009 20:34:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n630YcI0013642
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Jul 2009 20:34:38 -0400
Date: Thu, 2 Jul 2009 20:34:04 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Preemption question (4xx related)
Message-ID: <20090703003403.GA23124@zod.rchland.ibm.com>
References: <24271342.post@talk.nabble.com> <1246486393.14483.14.camel@pasglop>
	<20090702001450.GF6189@zod.rchland.ibm.com>
	<1246519992.7551.1.camel@pasglop>
	<20090702111246.GG6189@zod.rchland.ibm.com>
	<1246574460.7551.6.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246574460.7551.6.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 03, 2009 at 08:41:00AM +1000, Benjamin Herrenschmidt wrote:
>On Thu, 2009-07-02 at 07:12 -0400, Josh Boyer wrote:
>> On Thu, Jul 02, 2009 at 05:33:12PM +1000, Benjamin Herrenschmidt wrote:
>> >On Wed, 2009-07-01 at 20:14 -0400, Josh Boyer wrote:
>> >
>> >> I've toyed with that idea myself.  I keep coming back to the fact that you need
>> >> a workload that would really leverage it, and I don't have one at the moment.
>> >
>> >To some extent that's true but just turning full preemption including
>> >kernel side with all the associated debug bits and lockdep should make a
>> >whole bunch of things show up even with ordinary workloads.
>> 
>> I can look at doing that for ppc44x_defconfig.  I'll be honest and say I don't
>> expect it to go well, particularly with lockdep :).
>> 
>> >For 440 tend to boot an ubuntu distro off NFS root with all X & DRI 3D
>> >etc... and then run compiz :-)
>> 
>> Yes.  Because that's a totally realistic workload for a 440.  I'm surprised you
>> don't have a p595 machine acting as your home router too!  ;)
>
>It doesn't need to be realistic. In fact, a "realistic" workload is the
>worst thing to test with because it won't exercise all the "uncommon"
>code path which are the ones likely to bite.
>
>So yesm it's not a "realistic" workload, but it's a good "torture"
>workload to find bugs.

It was a joke.  But yes, you make perfectly valid points :)

josh
