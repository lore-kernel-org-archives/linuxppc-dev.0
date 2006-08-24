Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0648E67BE1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 20:54:26 +1000 (EST)
Subject: Re: [PATCH ] powerpc: Add tsi108/9 and non standard mpic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1156413135.6591.14.camel@localhost.localdomain>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
	<1156398135.5913.43.camel@localhost.localdomain>
	<1156398861.8433.197.camel@localhost.localdomain>
	<1156413135.6591.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 20:54:17 +1000
Message-Id: <1156416857.8433.244.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > The table should still contain the entries for a normal MPIC. One can
> > build a kernel that will boot both machines with the "weird" one and
> > with the normal one. Thus CONFIG_MPIC_WEIRD shall not exclude normal
> > MPICs, though not having it does exclude weird ones. I thus would
> > suggest to keep the table as it was in your earlier patches, that is
> > with the normal MPIC mapping at 0.
> > 
> > I intend to re-use that to handle another weird MPIC from some other
> > project :)
> 
> That is also my target. I hope the imported mpic_info table can support
> more non-standard mpic structure.
> The following patch adds the standard MPIC entry to the table. 
> I post it here.

Looks good. I still need to test it, hopefully tomorrow, then it can go
in though I'm not sure it can get into 2.6.18, we'll see.

Ben.
