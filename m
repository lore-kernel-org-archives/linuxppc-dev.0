Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6593CB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 12:28:44 +1000 (EST)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA468DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 12:28:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8F2MgW3027432
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 20:22:42 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8F2SePR249804
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 20:28:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8F2SejE025000
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 20:28:40 -0600
Date: Mon, 14 Sep 2009 22:28:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Fix bug where perf_counters breaks oprofile
Message-ID: <20090915022836.GF12372@zod.rchland.ibm.com>
References: <19111.37067.783017.427206@cargo.ozlabs.ibm.com>
	<4AA7AE3B.30809@us.ibm.com> <4AAEA40A.6040701@us.ibm.com>
	<20090914204348.GE12372@zod.rchland.ibm.com>
	<1252976208.8375.181.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1252976208.8375.181.camel@pasglop>
Cc: Paul Mackerras <paulus@samba.org>, Maynard Johnson <mpjohn@us.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2009 at 10:56:47AM +1000, Benjamin Herrenschmidt wrote:
>On Mon, 2009-09-14 at 16:43 -0400, Josh Boyer wrote:
>> On Mon, Sep 14, 2009 at 03:14:02PM -0500, Maynard Johnson wrote:
>> >Maynard Johnson wrote:
>> >> Paul Mackerras wrote:
>> >>> Currently there is a bug where if you use oprofile on a pSeries
>> >>> machine, then use perf_counters, then use oprofile again, oprofile
>> >>> will not work correctly; it will lose the PMU configuration the next
>> >>> time the hypervisor does a partition context switch, and thereafter
>> >>> won't count anything.
>> >Ben,
>> >Is there any way to get this bug fix into 2.6.31 or is the window closed?  Once the problem occurs, you can't get oprofile to work again without a reboot.  Really would be nice (for many reasons) to get this fixed in .31.
>> 
>> .31 is already released.  Could probably get it into a -stable .31 kernel
>> though.
>
>The fix is already upstream as well no ?

Sort of.  It's in your next branch, but not in Linus' tree.

Anyway, some people like to have particular versions work so -stable is good
regardless :).

josh
