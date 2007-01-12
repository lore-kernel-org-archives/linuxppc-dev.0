Return-Path: <>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73BEDDDEB9
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 08:32:02 +1100 (EST)
Date: Fri, 12 Jan 2007 16:28:45 -0500
From: Sonny Rao <sonny@burdell.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: 2.6.19: kernel BUG in hugepd_page at
	arch/powerpc/mm/hugetlbpage.c:58!
Message-ID: <20070112212845.GA2501@kevlar.boston.burdell.org>
References: <20070112195703.GA1826@kevlar.boston.burdell.org>
	<1168632510.12413.62.camel@localhost.localdomain>
	<20070112203017.GA2215@kevlar.boston.burdell.org>
	<20070112211159.GC4982@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070112211159.GC4982@us.ibm.com>
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

On Fri, Jan 12, 2007 at 01:11:59PM -0800, Nishanth Aravamudan wrote:
> On 12.01.2007 [15:30:17 -0500], Sonny Rao wrote:
> > On Fri, Jan 12, 2007 at 02:08:30PM -0600, Adam Litke wrote:
> > > On Fri, 2007-01-12 at 14:57 -0500, Sonny Rao wrote:
> > > > (Apologies if this is a re-post)
> > > >
> > > > Hi, I was running 2.6.19 and running some benchmarks using
> > > > libhugetlbfs (1.0.1) and I can fairly reliably trigger this bug:
> > >
> > > Is this triggered by a libhugetlbfs test case?  If so, which one?
> > 
> > Nope, this was an application/benchmark, but I'm running the testsuite
> > on the machine now to see if I can trigger it.
> 
> Any idea what the application/benchmark was trying to do? Does it happen
> to be open-source? :)

Unfortunately not, I haven't had any time to analyze what's going on.
It doesn't seem to happen all the time either, so it may take a while
before I know anything more.

Sonny
