Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82A82B6EF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 05:05:50 +1100 (EST)
Date: Mon, 7 Dec 2009 12:05:11 -0600
From: Scott Wood <scottwood@freescale.com>
To: =?utf-8?B?5p6X5b+X5bmz?= <solyn123@gmail.com>
Subject: Re: Ping does not work on my MPC8544 board, using linux2.6.23
Message-ID: <20091207180511.GA8914@loki.buserror.net>
References: <8148211e0912061953n59dfbe4fsea033494ad8b6fcc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <8148211e0912061953n59dfbe4fsea033494ad8b6fcc@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 07, 2009 at 11:53:22AM +0800, 林志平 wrote:
> Does dtc1.2.0 can compile dts files under linux2.6.23?

Probably not -- 2.6.23 is very old, and I think newer dtcs only support the
newer dts syntax.

> Another question is that I found linux2.6.31 does not support
> board mpc8544ds, 

It should.  What problems do you see?

> And I never boot linux-2.6.31 on my board, why linux-2.6.31 doesnot
> provide a config file like mpc8544_ds_defconfig?

Does mpc85xx_defconfig not work?

-Scott
