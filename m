Return-Path: <dave@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B476DF3AD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 06:33:43 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6SKXdBV010200
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:33:39 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6SKXQRY100522
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 14:33:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6SKXQd7008838
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 14:33:26 -0600
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Eric Munson <ebmunson@us.ibm.com>
In-Reply-To: <cover.1216928613.git.ebmunson@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 13:33:24 -0700
Message-Id: <1217277204.23502.36.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-28 at 12:17 -0700, Eric Munson wrote:
> 
> This patch stack introduces a personality flag that indicates the
> kernel
> should setup the stack as a hugetlbfs-backed region. A userspace
> utility
> may set this flag then exec a process whose stack is to be backed by
> hugetlb pages.

I didn't see it mentioned here, but these stacks are fixed-size, right?
They can't actually grow and are fixed in size at exec() time, right?

-- Dave
