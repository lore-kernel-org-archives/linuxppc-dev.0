Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4801067A3E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jul 2006 08:46:51 +1000 (EST)
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E05003@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E05003@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 08:39:40 +1000
Message-Id: <1152052780.13828.101.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, 'Paul Mackerras' <paulus@samba.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The problem is that we don't have this PPC_UBDG_16550 option configurable now,
> and it is only made by default for several boards including pseries, chrp, prep, cell,
> and all 83xx and 85xx platforms.  If we need to change the whole thing, how should we do it?

It's up to your platformn code to enable it though. udbg will only kick
in from the legacy serial console code if your firmware indicates that
stdout is on a serial port. If the firmware doesn't, udbg won't kick in.
But yeah, build it in by default if you want then.

Ben.
