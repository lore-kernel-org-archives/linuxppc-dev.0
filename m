Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out0.tiscali.nl (smtp-out0.tiscali.nl [195.241.79.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB374DDECC
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 04:46:23 +1100 (EST)
Message-ID: <472E0569.7070601@tiscali.nl>
Date: Sun, 04 Nov 2007 18:46:17 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Balance alloc/free and ioremap/iounmap in	gpio_mdio_probe
	(powerpc/platforms/pasemi/gpio_mdio.c)
References: <472DF914.7020601@tiscali.nl> <20071104174701.GB10191@lixom.net>
In-Reply-To: <20071104174701.GB10191@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Sun, Nov 04, 2007 at 05:53:40PM +0100, Roel Kluin wrote:
>> I think this is how it should be done, but
>> please review: it was not tested.
> 
> Hi,
> 
> Thanks for the bug report. The mdio driver needs a set of other cleanups
> as well. I have a more comprehensive patch that I'll post tomorrow after
> I have a chance to test them.

Ok, that's fine with me,

Roel
