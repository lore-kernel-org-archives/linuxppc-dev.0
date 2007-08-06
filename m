Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64813DDED7
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:19:04 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76JJ1x4000870
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 15:19:01 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l76JJ1Ke216620
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 13:19:01 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l76JJ0Qc009397
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 13:19:00 -0600
Date: Mon, 6 Aug 2007 14:19:00 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Page faults blowing up ... [was Re: [PATCH] Fix special PTE code
	for secondary hash bucket
Message-ID: <20070806191900.GC4357@austin.ibm.com>
References: <18098.61003.38084.554299@cargo.ozlabs.ibm.com>
	<20070803193258.GA9613@austin.ibm.com>
	<1186194688.5733.6.camel@gruick>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186194688.5733.6.camel@gruick>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, benh@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 04, 2007 at 12:31:28PM +1000, Benjamin Herrenschmidt wrote:
> 
> Paulus stuff is likely to be unrelated to your bug. Also, whatever blurb
> you pasted in this email is totally incomprehensible due to total lack
> of context.

Sorry. Mike Strosaker nailed it; its a nutty hypervisor bug.

--linas
