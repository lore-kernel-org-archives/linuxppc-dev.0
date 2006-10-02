Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF9D367BDF
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 03:24:20 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k92HOHmF003144
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 13:24:17 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k92HN1aD053016
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 11:23:01 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k92HN0E2006478
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 11:23:00 -0600
Date: Mon, 2 Oct 2006 12:23:00 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Message-ID: <20061002172300.GD4546@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
	<200609301240.03464.arnd@arndb.de>
	<20061002162749.GB4546@austin.ibm.com>
	<200610021850.41062.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200610021850.41062.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 02, 2006 at 06:50:39PM +0200, Arnd Bergmann wrote:
> On Monday 02 October 2006 18:27, Linas Vepstas wrote:
> > > 
> > > I'm not sure if I have missed a patch in here, but I
> > > don't see anything reintroducing the 'netif_stop_queue'
> > > that is missing from the transmit path.
> > > 
> > > Do you have a extra patch for that?
> > 
> > Unfinished.  There are several ways in which the current 
> > spider-net driver doesn't do things the way Greg KH's, etal 
> > book on device drivers recommends. I was planning on combing 
> > through these this week.
> 
> Ok, that's good. However, removing the netif_stop_queue
> was an obvious oversight that happened during the cleanup
> last year.
> 
> Putting that one line back in should be a really safe fix for
> the problem of overly high system load we sometimes see.

Hmm. I have a patch from 5 weeks ago that seems to insert a bunch 
of these. I'm not sure why it hadn't been mailed before, I'll 
test and post as soon as I can.

--linas
