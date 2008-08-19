Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F8E9DE257
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 08:22:24 +1000 (EST)
Date: Tue, 19 Aug 2008 23:04:36 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] rtc: rtc-ds1374: fix 'no irq' case handling
Message-ID: <20080819230436.6b2fbb4a@lxorguk.ukuu.org.uk>
In-Reply-To: <9e4733910808191423u34946955lc85caa6b2217b390@mail.gmail.com>
References: <20080812161733.GA32164@oksana.dev.rtsoft.ru>
	<9e4733910808191339s28a05f90pef57961e8d24fbdb@mail.gmail.com>
	<20080819212937.01dfd024@lxorguk.ukuu.org.uk>
	<9e4733910808191423u34946955lc85caa6b2217b390@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't know the status of these platforms....
> 
> asm-blackfin/irq.h:#define NO_IRQ ((unsigned int)(-1))
> asm-mn10300/irq.h:#define NO_IRQ		INT_MAX
> asm-parisc/irq.h:#define NO_IRQ		(-1)

In need of fixing, assuming they actually use NO_IRQ for anything - don't
be mislead by the fact they may have old defines lying around.

Alan
