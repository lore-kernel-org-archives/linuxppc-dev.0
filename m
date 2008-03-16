Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13200DDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 07:38:42 +1100 (EST)
Subject: Re: PPC upstream kernel ignored DABR bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <2f8f82fe943fcd5103ec4cc39cc1bb26@kernel.crashing.org>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
	<20080313014745.DE97826F992@magilla.localdomain>
	<2f8f82fe943fcd5103ec4cc39cc1bb26@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 07:37:51 +1100
Message-Id: <1205699871.26869.114.camel@pasglop>
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


> Since the 970 kernel never sets DABRX currently, #8 cannot explain
> _intermittent_ problems: either it always works, or never does.

Uh... could be the boot code setting it, the setting happening on LSU0
but not LSU1. No ?

Ben.
