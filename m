Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CED29DDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 07:29:30 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l69LTRfM003349
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 17:29:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l69LTRZS492800
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 17:29:27 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l69LTQ3w002130
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 17:29:27 -0400
Date: Mon, 9 Jul 2007 16:29:26 -0500
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Message-ID: <20070709212926.GN4457@austin.ibm.com>
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de> <4692A5B8.9010702@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4692A5B8.9010702@freescale.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2007 at 04:16:40PM -0500, Scott Wood wrote:
> Arnd Bergmann wrote:
> > I may be missing the obvious, but doesn't that defeat the purpose of
> > non-executable mappings?
> 
> The hardware in question doesn't support non-executable mappings; 
> otherwise, it'd never have worked in the first place.  Note that this is 
> only allowed on 32-bit, non-book-E.
> 
> There isn't much value in enforcing non-exec mappings only if it happens 
> to be the first fault on a given page.

Thank you. I was reading this thread last week, and scratching my head,
thinking wtf ??

--linas
