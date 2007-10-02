Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12636DDFCF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 09:28:27 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l92NSOG7029153
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 19:28:24 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l92NSOTs536820
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 19:28:24 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l92NSOeA019412
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 19:28:24 -0400
Date: Tue, 2 Oct 2007 18:28:19 -0500
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.23-rc7-mm1 -- powerpc rtas panic
Message-ID: <20071002232819.GN4338@austin.ibm.com>
References: <20070924021716.9bfe7dfb.akpm@linux-foundation.org>
	<20070924123531.GC30855@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070924123531.GC30855@shadowen.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 01:35:31PM +0100, Andy Whitcroft wrote:
> Seeing the following from an older power LPAR, pretty sure we had
> this in the previous -mm also:

I haven't forgetten about this ... and am looking at it now.
Seems that whenever I go to reserve the machine pSeries-102,
someone else is using it :-)

--linas
