Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BBC8DDDEA3
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 04:08:32 +1100 (EST)
Date: Sun, 3 Feb 2008 20:08:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 0/11] Patches needed to support QE USB Host Controller
Message-ID: <20080203170820.GA18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: David Brownell <david-b@pacbell.net>, linux-usb@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

These patches are needed to support "FHCI" host controller.

This includes:

- GPIO LIB support for PowerPC;
- GPIO LIB support for QUICC Engine;
- gpio_set_dedicated() addition to GPIO LIB;
- QE LIB additions: usb, gtm;
- FHCI driver;
- Support for MPC8360E-RDK as an example.

I have already posted GPIO LIB support for PowerPC/QE, but since
patches changed a bit, I thought it's good idea to take a chance
and repost them for the next RFC round.

Thanks,

p.s.

David, I'm Cc:ing you to this patchset (except qe_gtm, and qe_usb
patches -- nothing insteresting), to show the complete picture of
why we need additions to GPIO LIB.

Also will appreciate any comments regarding GPIO LIB support for
PowerPC/QE.

linux-usb Cc'ed only for FHCI driver patch.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
