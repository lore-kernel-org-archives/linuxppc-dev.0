Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9959ADDED6
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 21:38:16 +1000 (EST)
Subject: Re: [RFC/PATCH 4/4] powerpc: Make syscall restart code more common
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070602101239.GA21478@lst.de>
References: <20070530080527.6AA6CDDFD0@ozlabs.org>
	<20070602101239.GA21478@lst.de>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 21:38:00 +1000
Message-Id: <1180784280.14025.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ulrich.weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Here's an updated version to create a signal.[ch] instead.  It will be
> used by the signal consolidation patches I'll post now.

Excellent, thanks !

Cheers,
Ben.
