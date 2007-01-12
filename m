Return-Path: <nacc@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDF81DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 08:12:09 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0CLC4Qf024622
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:12:04 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0CLC3J6417456
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 14:12:03 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0CLC2aD011438
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 14:12:03 -0700
Date: Fri, 12 Jan 2007 13:11:59 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Sonny Rao <sonny@burdell.org>
Subject: Re: 2.6.19: kernel BUG in hugepd_page at
	arch/powerpc/mm/hugetlbpage.c:58!
Message-ID: <20070112211159.GC4982@us.ibm.com>
References: <20070112195703.GA1826@kevlar.boston.burdell.org>
	<1168632510.12413.62.camel@localhost.localdomain>
	<20070112203017.GA2215@kevlar.boston.burdell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070112203017.GA2215@kevlar.boston.burdell.org>
Cc: linuxppc-dev@ozlabs.org, dwg@au1.ibm.com,
	libhugetlbfs-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12.01.2007 [15:30:17 -0500], Sonny Rao wrote:
> On Fri, Jan 12, 2007 at 02:08:30PM -0600, Adam Litke wrote:
> > On Fri, 2007-01-12 at 14:57 -0500, Sonny Rao wrote:
> > > (Apologies if this is a re-post)
> > >
> > > Hi, I was running 2.6.19 and running some benchmarks using
> > > libhugetlbfs (1.0.1) and I can fairly reliably trigger this bug:
> >
> > Is this triggered by a libhugetlbfs test case?  If so, which one?
> 
> Nope, this was an application/benchmark, but I'm running the testsuite
> on the machine now to see if I can trigger it.

Any idea what the application/benchmark was trying to do? Does it happen
to be open-source? :)

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
