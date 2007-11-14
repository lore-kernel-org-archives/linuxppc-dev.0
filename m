Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FE20DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 12:18:10 +1100 (EST)
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910711131553ked87330ubc0c439c42e51ace@mail.gmail.com>
References: <20071113214845.85820@gmx.net>
	<fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>
	<fa686aa40711131359l43f289e7j48b0df3ff57ea7c7@mail.gmail.com>
	<FA44C867-4933-40F2-8EBA-5C9967005223@embeddedalley.com>
	<20071113233906.GA32689@lixom.net>
	<9e4733910711131553ked87330ubc0c439c42e51ace@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 12:17:58 +1100
Message-Id: <1195003078.28865.18.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> That's why Dominic wants to get OpenOCD running on the PowerPC. All we
> need is the programming documentation for controlling the CPU via the
> debug hardware.

Note that this is basically different for every CPU around.

> Obviously this documentation exist, all of the commercial vendors had
> to have it to develop their debuggers. Maybe it is already out there
> and we just don't know where to look.

Ben.
