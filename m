Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D407DE032
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 02:18:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l51GEA2h002686
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 12:14:10 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l51GIIal240164
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 10:18:18 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l51GIHBM001057
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 10:18:18 -0600
Date: Fri, 1 Jun 2007 11:18:17 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] Use NO_IRQ not IRQ_NONE
Message-ID: <20070601161817.GJ7298@austin.ibm.com>
References: <526423a25b0e40c03678f4bb1d56e4b5719ab74d.1180682602.git.michael@ellerman.id.au>
	<1180684052.19517.422.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180684052.19517.422.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 01, 2007 at 05:47:32PM +1000, Benjamin Herrenschmidt wrote:
> My fault actually :-) Mostly a typo, it's right elsewhere in the code
> except in those 3 occurences. Brown paper bag time for me.

Trying to make the rest of us look bad?  By those standards, 
I'd be wearing 23 brown paper bags at the same time, all the time.

--linas
