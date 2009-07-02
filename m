Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 35AFDB77A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 10:15:32 +1000 (EST)
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99E55DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 10:15:31 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n620ARxf016259
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 20:10:27 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n620FOSH249158
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 20:15:24 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n620FOqS024576
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 20:15:24 -0400
Date: Wed, 1 Jul 2009 20:14:50 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Preemption question (4xx related)
Message-ID: <20090702001450.GF6189@zod.rchland.ibm.com>
References: <24271342.post@talk.nabble.com> <1246486393.14483.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246486393.14483.14.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 02, 2009 at 08:13:13AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2009-06-30 at 05:55 -0700, Felix Radensky wrote:
>> Hi,
>> 
>> Preemption is disabled on the vast majority of powerpc
>> targets. Are there any known problems in this area ?
>> I'd like to enable CONFIG_PREEMPT_VOLUNTARY on
>> AMCC 405EX target, to increase application responsiveness.
>> Is it a bad idea ?
>
>In theory it should work, but as you may have noticed, it's generally
>disabled and thus not very well tested.
>
>It would be a good idea for us, some of the core devs, to turn that on
>in our usual test configs in fact.

I've toyed with that idea myself.  I keep coming back to the fact that you need
a workload that would really leverage it, and I don't have one at the moment.

josh
