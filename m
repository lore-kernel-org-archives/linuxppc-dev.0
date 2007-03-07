Return-Path: <mohan@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC6B8DDF37
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 16:08:23 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l27576Bn031116
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 00:07:06 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2758KFc426958
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 22:08:20 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2758KSU004579
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 22:08:20 -0700
Date: Wed, 7 Mar 2007 10:38:00 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Clearing the interrupt
Message-ID: <20070307050800.GI7476@in.ibm.com>
References: <20070306173941.GE7476@in.ibm.com>
	<1173215087.9349.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173215087.9349.17.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 06, 2007 at 10:04:47PM +0100, Benjamin Herrenschmidt wrote:
> > Is there any problem with the above approach? Is there any restriction
> > such that a cpu which acknowledged the interrupt only should send the eoi
> > signal?
> 
> While I don't think there -should- be any restriction, I also seem to
> remember that the xics "emulation" done by the firmware on things like
> JS20 requires the eoi to be done from the CPU where the interrupt
> originated.
>

Thanks Ben.

If thats the case, is it okay to call eoi handler from all cpus so that
above case will be satisfied?

Regards,
Mohan.
