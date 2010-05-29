Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EEE6B7D1A
	for <linuxppc-dev@ozlabs.org>; Sat, 29 May 2010 13:36:06 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: Add i8042 keyboard and mouse irq parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTikve-ZghgpVl3cyjjgWAch-oCJ0EiYK2127f5gS@mail.gmail.com>
References: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<AANLkTikve-ZghgpVl3cyjjgWAch-oCJ0EiYK2127f5gS@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 29 May 2010 13:35:53 +1000
Message-ID: <1275104153.1931.522.camel@pasglop>
Mime-Version: 1.0
Cc: Martyn Welch <martyn.welch@ge.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> The patch looks okay to me.
> 
> BTW, where is the i8042 binding documented?  Ben, is this location of
> the kbd/mouse irq historical, or is it just something that we happened
> to get when the .dts files were first created?  Having the irq
> specified directly in the kbd or aux nodes would make a lot more
> sense, and if this isn't something already nailed down, then it
> probably does make sense to move the irq specification, fall back to
> the parent node to still support older trees, and with the hard coded
> irq numbers as the last resort.

That's just ISA crap. It should be in the existing OF bindings.

Cheers,
Ben.
