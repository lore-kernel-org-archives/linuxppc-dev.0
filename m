Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC9B8DDE42
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 08:54:15 +1000 (EST)
Subject: Re: [RFC/PATCH 2/5] powerpc: Cleanup ptrace bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070601212247.GA27149@lst.de>
References: <20070529064531.D874CDDF70@ozlabs.org>
	<20070601212247.GA27149@lst.de>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 08:54:02 +1000
Message-Id: <1180738442.19517.461.camel@localhost.localdomain>
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

On Fri, 2007-06-01 at 23:22 +0200, Christoph Hellwig wrote:
> This one doesn't seem to apply against current mainline plus the first
> patch.  The hung in ptrace.c rejects.

It needs the 32 bits single step fixup that I posted a few days ago...

Ben.
