Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 943B8DE9E4
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 07:11:00 +1000 (EST)
In-Reply-To: <20080421182953.GB6111@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804191051420.20132@blarg.am.freescale.net>
	<fa686aa40804191114i2cef26eegabfe9bc28d8ecc18@mail.gmail.com>
	<5422E8EE-4AFA-491B-8920-BDEBF596FF00@kernel.crashing.org>
	<20080421182953.GB6111@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <00248a3c226d44aa352ebb69894183f4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [PPC] Remove mpc8272 ads board from arch/ppc
Date: Mon, 21 Apr 2008 23:10:47 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Speaking of making it obvious, is it time to put a #warning in some
> prominent arch/ppc header?

The last time arch/ppc built for me (a few days ago), it got
535 warnings.  I don't think anyone would notice one more.
Also, whoever doesn't yet know arch/ppc will be going away
has been living under a rock for the last two years.


Segher
