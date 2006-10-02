Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49A2067BB7
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 02:27:54 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k92GRo4n013526
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 12:27:50 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k92GRoDC284920
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 12:27:50 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k92GRnER013822
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 12:27:50 -0400
Date: Mon, 2 Oct 2006 11:27:49 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Message-ID: <20061002162749.GB4546@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
	<200609301240.03464.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200609301240.03464.arnd@arndb.de>
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

On Sat, Sep 30, 2006 at 12:40:00PM +0200, Arnd Bergmann wrote:
> Am Saturday 30 September 2006 01:05 schrieb Linas Vepstas:
> >
> > Although these patches improve things, I am not
> > satisfied with how this driver behaves, and so
> > plan to do additional work next week.
> >
> 
> I'm not sure if I have missed a patch in here, but I
> don't see anything reintroducing the 'netif_stop_queue'
> that is missing from the transmit path.
> 
> Do you have a extra patch for that?

Unfinished.  There are several ways in which the current 
spider-net driver doesn't do things the way Greg KH's, etal 
book on device drivers recommends. I was planning on combing 
through these this week.

--linas
