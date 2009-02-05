Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3744DDDD8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 07:58:31 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n15KuJew011637
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Feb 2009 13:56:19 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n15KwR3K089576
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Feb 2009 13:58:27 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n15KwRMi019723
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Feb 2009 13:58:27 -0700
Date: Thu, 5 Feb 2009 15:58:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ANN] Introducing new "test" branch in powerpc.git tree
Message-ID: <20090205205809.GA10793@zod.rchland.ibm.com>
References: <1233806493.4612.65.camel@pasglop>
	<20090205134700.GB3000@yoda.jdub.homelinux.org>
	<1233867382.4612.98.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233867382.4612.98.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 06, 2009 at 07:56:22AM +1100, Benjamin Herrenschmidt wrote:
>
>> Which begs the question of what master is for.  So far, it's just been
>> a mirror of next from what I can tell.  Maybe it should just track
>> Linus' tree?
>
>I've been wondering myself what to do with it ... I may just leave it to
>track linus indeed. Or maybe just delete it.

I don't think you can delete it without hosing people who try to clone it.

josh
