Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0DD3167B54
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 08:07:05 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IM720w024316
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 18:07:02 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IM721G361328
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:07:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IM71bh020859
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:07:02 -0600
Date: Fri, 18 Aug 2006 17:07:00 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 0/6]:  powerpc/cell spidernet ethernet driver update
Message-ID: <20060818220700.GG26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Jeff,

Can you apply and forward upstream the following series of patches?
This is the same set of patches I sent only a few days ago; however,
it appears that I failed to cc you on some of them, and I failed to
ask anyone in particular to actually apply them. So I'm asking now. :-)

The maintainership of the spidernet driver is transitioning from
Utz Bacher and Jens Osterkamp to Jim Lewis; you should be receiving
a patch to the MAINTAINERS file from Jim, noting this, shortly.  
I suspect that neither Utz nor Jens will be ack'ing or nack'ing 
these patches unless prodded; let me know if you want some particlar
ack from someone before you apply these. (BenH and Arnd Bergmann
are the ones who usually keep us honest about these things.)

Although these are based on a week-old mm tree, they should 
apply cleanly just about anywhere, as there has been little/no 
change to this code base in a long while. 

The patches bring the transmit performance of the driver up
to a decent level, as reviewed in greter detail in the patch
descriptions.

--linas
