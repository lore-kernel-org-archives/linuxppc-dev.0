Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AFD1B7D61
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 17:25:45 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: Add i8042 keyboard and mouse irq parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <20100602062634.GA3713@core.coreip.homeip.net>
References: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<1275104126.1931.521.camel@pasglop> <4C050017.10905@ge.com>
	<20100602062634.GA3713@core.coreip.homeip.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 17:25:32 +1000
Message-ID: <1275463532.1931.773.camel@pasglop>
Mime-Version: 1.0
Cc: Martyn Welch <martyn.welch@ge.com>, linux-input@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-06-01 at 23:26 -0700, Dmitry Torokhov wrote:
> 
> FYI: i8042 core expects I8042_{KBD|AUX}_IRQ to be integers, however it
> is certainly fixable...

Let's not bother.

Cheers,
Ben.
