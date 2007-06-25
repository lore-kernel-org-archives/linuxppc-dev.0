Return-Path: <SRS0+7cfff2985c2512d6f44d+1401+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63205DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 05:39:20 +1000 (EST)
Date: Mon, 25 Jun 2007 20:39:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] pcmcia: CompactFlash driver for PA Semi Electra boards
Message-ID: <20070625193909.GA26021@infradead.org>
References: <20070625010311.GA31355@lixom.net>
	<20070625171221.GA6684@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070625171221.GA6684@lixom.net>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2007 at 12:12:21PM -0500, Olof Johansson wrote:
> Driver for the CompactFlash slot on the PA Semi Electra eval board. It's
> a simple device sitting on localbus, with interrupts and detect/voltage
> control over GPIO.
> 
> The driver is implemented as an of_platform driver, and adds localbus
> as a bus being probed by the of_platform framework.

Looks good to me. The only odd thing is the inconsistant use of
#ifdef CONFIG_PCMCIA in setup.c.
