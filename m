Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 83156DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 23:34:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] add Kconfig option for optimizing for cell
Date: Sat, 15 Sep 2007 15:30:15 +0200
References: <200709150221.57825.arnd@arndb.de>
	<1189862035.3742.5.camel@shinybook.infradead.org>
In-Reply-To: <1189862035.3742.5.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200709151530.15441.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 15 September 2007, David Woodhouse wrote:
> On Sat, 2007-09-15 at 02:21 +0200, Arnd Bergmann wrote:
> > Since the PPE on cell is an in-order core, it suffers significantly
> > from wrong instruction scheduling. This adds an Kconfig option that
> > enables passing -mtune=cell to gcc in order to generate object
> > code that runs well on cell.
> 
> Do we have an option which is useful for a multiplatform kernel (and for
> userspace) and which lies between the two extremes? Something which will
> improve performance on Cell (and POWER6?) without sucking too hard
> elsewhere?

No, not really. The impact of -mtune=cell should not be too bad on other
out-of-order CPUs, but we don't have any good measurements to back that
up, and it may also be really bad for POWER6 and other in-order cores.

	Arnd <><
