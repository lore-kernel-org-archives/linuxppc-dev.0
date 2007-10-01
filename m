Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27071DDDFE
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 11:51:08 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l911p2BO020541
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 21:51:02 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l911p2Zc427120
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 19:51:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l911p2tB029792
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 19:51:02 -0600
Subject: Re: [PATCH 0/3] Bug fixes to Virtex support in arch/ppc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
References: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain
Date: Sun, 30 Sep 2007 20:49:55 -0500
Message-Id: <1191203395.10089.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-09-30 at 15:46 -0600, Grant Likely wrote:
> Josh,
> 
> Here are some small bug fixes to arch/ppc.  They are all pretty trivial,
> and I think they should go in for 2.6.24.  If there are no problems with
> them, can you please merge them into your tree and ask paulus to pull
> them?

Yep.  These all seem truly bug-fix and sane.  I'll pull them into my
tree tomorrow.

josh
