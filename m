Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id DAFFE1007D3
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 05:09:59 +1100 (EST)
Date: Mon, 25 Jan 2010 21:09:57 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 0/4] OF GPIO integration for I2C/SPI GPIO chips
Message-ID: <20100125180957.GA5380@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bill Gatliff <bgat@billgatliff.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Currently it's a burden to make I2C or SPI GPIO chips work with the
OF GPIO infrastructure. I've posted several approaches to solve the
issue before, and others have tried too. Here is another try.

This patch set is used to make things much easier, and completely
seamless for GPIO chips that don't need any platform data (e.g.
mcu_mpc8349emitx) or that have OF bindings already (e.g. pca953x).

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
