Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F285867A6D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 10:40:53 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Dorchain <joerg@dorchain.net>
In-Reply-To: <20050315140329.GA15214@Redstar.dorchain.net>
References: <1110767622.5787.215.camel@gaston>
	<20050315140329.GA15214@Redstar.dorchain.net>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 10:35:35 +1100
Message-Id: <1110929735.24296.38.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Newer laptops & CPU speed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> My ibook G4 boots at low speed. /proc/cpuinfo shows 666MHz and a smiliar
> bogomips value. Nevertheless, the cpu frequency scaler works, i.e. set
> it to performance to be at high speed after boot up, or, as I currently
> do, use the userspace governor and powernowd. All this is without your
> patch (Did not try it yet, my ibook lacks internet) on linus' 2.6.11.

Sure, I already had support for some models :) The patch extends it to
all present and future models that are MacRISC3 and have a 7447A CPU.

Ben.
