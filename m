Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9291B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 20:16:17 +1000 (EST)
Subject: Re: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20110627101414.GA9369@crust.elkhashab.com>
References: <178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop> <1304487166.2513.351.camel@pasglop>
	<BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
	<20110509160935.GA14965@crust.elkhashab.com>
	<6a09a426f126fb315b773fc207d68eb9@mail.gmail.com>
	<1306208412.7481.214.camel@pasglop>
	<20110527165108.GA1752@crust.elkhashab.com>
	<fa765cbed63d89c50a79b34f25dc9f5c@mail.gmail.com>
	<20110627101414.GA9369@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Jun 2011 20:15:53 +1000
Message-ID: <1309169753.32158.388.camel@pasglop>
Mime-Version: 1.0
Cc: Tirumala Marri <tmarri@apm.com>, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Tony Breeds <tonyb@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-06-27 at 05:14 -0500, Ayman El-Khashab wrote:
> > I took care of that in my patch.  Basically it let the
> > system go to gen-2 speeds and negotiate down.
> > [marri] Great thx.
> 
> Ok, so I am back from doing whatever it is that I do.  Shall
> I go ahead and take a stab at making a new functor to handle
> the "link check"? -- which IIRC was the thought from last
> month about how best to handle the 460SX and whatever some
> people were using internally. 

Catch up with Tony (CC), he's working on something similar for a new
variant of that PCIe controller used internally by some IBM stuff.

Cheers,
Ben.
