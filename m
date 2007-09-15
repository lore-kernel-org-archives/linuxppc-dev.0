Return-Path: <SRS0+a874339cbf5423ccf6d8+1483+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81E96DDD0A
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 23:14:02 +1000 (EST)
Subject: Re: [PATCH] add Kconfig option for optimizing for cell
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200709150221.57825.arnd@arndb.de>
References: <200709150221.57825.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 15 Sep 2007 14:13:55 +0100
Message-Id: <1189862035.3742.5.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-09-15 at 02:21 +0200, Arnd Bergmann wrote:
> Since the PPE on cell is an in-order core, it suffers significantly
> from wrong instruction scheduling. This adds an Kconfig option that
> enables passing -mtune=cell to gcc in order to generate object
> code that runs well on cell.

Do we have an option which is useful for a multiplatform kernel (and for
userspace) and which lies between the two extremes? Something which will
improve performance on Cell (and POWER6?) without sucking too hard
elsewhere?

-- 
dwmw2
