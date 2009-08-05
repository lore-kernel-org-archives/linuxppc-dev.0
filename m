Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 46D81B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 23:16:18 +1000 (EST)
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A643FDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 23:16:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n75DFew9001360
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 09:15:40 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75DGCPr242658
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 09:16:13 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n75DGCIZ012178
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 09:16:12 -0400
Date: Wed, 5 Aug 2009 09:16:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Fix switch_mmu_context to iterate of the
	proper list of cpus
Message-ID: <20090805131608.GC8985@zod.rchland.ibm.com>
References: <1249443212-25588-1-git-send-email-galak@kernel.crashing.org>
	<20090805113230.GB8985@zod.rchland.ibm.com>
	<1249476742.5607.2.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1249476742.5607.2.camel@concordia>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 05, 2009 at 10:52:22PM +1000, Michael Ellerman wrote:
>On Wed, 2009-08-05 at 07:32 -0400, Josh Boyer wrote:
>> On Tue, Aug 04, 2009 at 10:33:32PM -0500, Kumar Gala wrote:
>> >Introduced a temporary variable into our iterating over the list cpus
>> >that are threads on the same core.  For some reason Ben forgot how for
>> >loops work.
>> 
>> Have the powerpoint demons corrupted him already??
>
>No I think one of his kids gave him swine flu.

Whew.  You can recover from that at least ;)

josh
