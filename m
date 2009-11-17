Return-Path: <cbouatmailru@gmail.com>
Received: from mail-fx0-f215.google.com (mail-fx0-f215.google.com
	[209.85.220.215]) by ozlabs.org (Postfix) with ESMTP id C1EC8B6EF1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 11:00:42 +1100 (EST)
Received: by fxm7 with SMTP id 7so615316fxm.9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 16:00:40 -0800 (PST)
Date: Tue, 17 Nov 2009 23:18:51 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC PATCH 1/5] Rework OpenFirmware GPIO handling
Message-ID: <20091117201851.GA27574@oksana.dev.rtsoft.ru>
References: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
	<1258472546-31343-2-git-send-email-dbaryshkov@gmail.com>
	<20091117161244.GA6849@oksana.dev.rtsoft.ru>
	<20091117200821.GA3154@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091117200821.GA3154@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2009 at 09:08:21PM +0100, Wolfram Sang wrote:
> > And it turned out that the only sane solution is to write
> > OF-pdata-hooks for the each driver (that we do for many drivers
> > already):
> 
> Or to support Grant in getting rid of of_platform :)

No, of_platform is completely other stuff. This won't help I2C/SPI
drivers.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
