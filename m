Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 193C6DDFDC
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 08:32:43 +1100 (EST)
Message-ID: <48EE7872.8070104@freescale.com>
Date: Thu, 09 Oct 2008 16:32:34 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sven Luther <sven@genesi-usa.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
References: <1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop> <48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
	<48EE3636.7020305@genesi-usa.com>
	<ed82fe3e0810091023j5f746a9cs7f8564c1e6ea8dcb@mail.gmail.com>
	<20081009201833.GA14746@powerlinux.fr>
	<ed82fe3e0810091414i32ed515di62230a3f4ac78a03@mail.gmail.com>
	<20081009212821.GA15626@powerlinux.fr>
In-Reply-To: <20081009212821.GA15626@powerlinux.fr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven Luther wrote:

> You just turn it on by default for 64bit and idsable it for 32bit :)

That hack might work for now, but it will break once we have 64-bit embedded
systems.  Regardless, it doesn't address the core issue - there should be no
default platform for PowerPC.

-- 
Timur Tabi
Linux kernel developer at Freescale
