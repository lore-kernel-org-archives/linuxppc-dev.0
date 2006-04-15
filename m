Return-Path: <schmitz@zirkon.biophys.uni-duesseldorf.de>
Received: from zirkon.biophys.uni-duesseldorf.de
	(zirkon.biophys.uni-duesseldorf.de [134.99.176.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15E6F67A39
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 21:19:35 +1000 (EST)
Date: Sat, 15 Apr 2006 13:12:57 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
In-Reply-To: <17471.62187.774127.783000@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0604151312320.12889-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Becky Bruce <Becky.Bruce@freescale.com>, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Actually, I think the problem is that the code linux is using to turn
> > on nap mode is not guaranteed to put the processor in nap mode by the
> > time the blr in ppc6xx_idle occurs.
>
> Thanks, Becky.
>
> This patch fixes it for me.  Comments, anyone?

Works for me :-)

	Michael
