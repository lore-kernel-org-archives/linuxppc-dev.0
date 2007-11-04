Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7BFEADDEF9
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 04:38:03 +1100 (EST)
Date: Sun, 4 Nov 2007 11:47:01 -0600
From: Olof Johansson <olof@lixom.net>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH] Balance alloc/free and ioremap/iounmap in
	gpio_mdio_probe (powerpc/platforms/pasemi/gpio_mdio.c)
Message-ID: <20071104174701.GB10191@lixom.net>
References: <472DF914.7020601@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <472DF914.7020601@tiscali.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 04, 2007 at 05:53:40PM +0100, Roel Kluin wrote:
> I think this is how it should be done, but
> please review: it was not tested.

Hi,

Thanks for the bug report. The mdio driver needs a set of other cleanups
as well. I have a more comprehensive patch that I'll post tomorrow after
I have a chance to test them.


-Olof
