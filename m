Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD0712BE83
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2004 10:26:41 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
In-Reply-To: <6upt25ezr4.fsf@zork.zork.net>
References: <1100847411.25521.42.camel@gaston>
	<1100852423.3855.2.camel@gaston> <1101083578.13597.5.camel@gaston>
	<6ullcuggfr.fsf@zork.zork.net>
	<4517b8e04112208383cc9b24c@mail.gmail.com>
	<6uzn19g299.fsf@zork.zork.net> <1101160349.22529.123.camel@gaston>
	<6upt25ezr4.fsf@zork.zork.net>
Content-Type: text/plain
Date: Wed, 24 Nov 2004 10:25:46 +1100
Message-Id: <1101252346.24532.21.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Keith Conger <keith.conger@gmail.com>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	gentoo-ppc-user@gentoo.org
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2004-11-23 at 08:27 +0000, Sean Neakums wrote:

> On resume this morning, though, the display was behaving oddly, both
> in X and on the console: it was sort of shimmering, split and repeated
> about 1/5 of the screen's width to the right in what looked like
> 8-pixel horizontal stripes.  Rebooting seemed to sort it.

Next time, please try to take a picture of the screen. Also, try
sleeping & waking up again and tell me if that helps.

Ben.
