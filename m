Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1CD6B7DC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Feb 2010 16:43:37 +1100 (EST)
Subject: powerpc -next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 16:43:30 +1100
Message-ID: <1265003010.8287.34.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So I'm about to do a proper -next branch for the next round (it's about
time !). I'll probably push a handful or two of things in my 'test'
branch tonight, which are then going to hit -next in a day or two if
nobody complains.

There's more to pickup though.

However, the bulk of the stuff pending on patchwork this time around
seems to be freescale related and thus will go through Kumar or Grant
for 52xx related bits.

Kumar, when do you expect to have a -next for me ?

Cheers,
Ben.
