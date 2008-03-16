Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1F01DDEDE
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 07:39:26 +1100 (EST)
Subject: Re: PPC upstream kernel ignored DABR bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <50c1640385e5eecc50430869175a70c7@kernel.crashing.org>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
	<20080313014745.DE97826F992@magilla.localdomain>
	<2f8f82fe943fcd5103ec4cc39cc1bb26@kernel.crashing.org>
	<20080313224234.0A4FB26F993@magilla.localdomain>
	<7d9961563967d5f810a5f597519a7c63@kernel.crashing.org>
	<20080314074547.BC48926F995@magilla.localdomain>
	<50c1640385e5eecc50430869175a70c7@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 07:38:43 +1100
Message-Id: <1205699923.26869.116.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jan Kratochvil <jan.kratochvil@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Roland McGrath <roland@redhat.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-03-14 at 09:42 +0100, Segher Boessenkool wrote:
> > I saw no effect from that change.  So now we're back to pure
> mystery, 
> > I guess.
> 
> Hey, we know something now: it's "just" a problem in the kernel :-)

We don't know that for sure. The DABR context switching code is trivial
enough...

Ben.
