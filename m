Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C397D67C02
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 03:14:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9KHDvSj026140
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 13:13:57 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9KHDvW1147620
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 13:13:57 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9KHDuj9027312
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 13:13:57 -0400
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4538F2A2.5040305@shadowen.org>
References: <1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	<17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
	<17720.30804.180390.197567@cargo.ozlabs.ibm.com>
	<4538DACC.5050605@shadowen.org>  <4538F2A2.5040305@shadowen.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 12:13:49 -0500
Message-Id: <1161364430.8946.67.camel@farscape>
Mime-Version: 1.0
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Christoph Lameter <clameter@sgi.com>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-20-10 at 17:00 +0100, Andy Whitcroft wrote:
> Andy Whitcroft wrote:
> > Paul Mackerras wrote:
> >> Christoph Lameter writes:

> Ok, I've just gotten a successful boot on this box for the first time in
> like 15 git releases.  I needed the three patches below:
> 
> clameter-fallback_alloc_fix2 -- from earlier in this thread, under the
> message ID below:
>     <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
> 
> Reintroduce-NODES_SPAN_OTHER_NODES-for-powerpc -- the patch I just
> submitted, under the message ID below:
>     <8a76dfd735e544016c5f04c98617b87d@pinky>
> 
> ibmveth-fix-index-increment-calculation -- this patch is already in -mm.
> 
> Feel free to take this as an ACK for the patches other than mine.
> 
> Acked-by: Andy Whitcroft <apw@shadowen.org>
> 
> -apw

I've applied these three blobs to the linux-2.6.git tree and verified
that it does fix the problem.        
And a "Thanks!" to Christoph for being responsive.. even when the
problem wasnt introduced by him. :)

Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
