Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D6F1DDE220
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 23:03:51 +1000 (EST)
Date: Fri, 30 May 2008 17:03:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080530130350.GA23252@polina.dev.rtsoft.ru>
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163900.GD16137@polina.dev.rtsoft.ru>
	<8E7E138E-E6D7-45FA-885F-380A82ECEC63@kernel.crashing.org>
	<20080527151628.GA11517@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080527151628.GA11517@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 27, 2008 at 07:16:28PM +0400, Anton Vorontsov wrote:
> On Tue, May 27, 2008 at 10:04:20AM -0500, Kumar Gala wrote:
> >
> > On May 23, 2008, at 11:39 AM, Anton Vorontsov wrote:
> >
> >> This is needed to access QE GPIOs via Linux GPIO API.
> >>
> >> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >> Acked-By: Timur Tabi <timur@freescale.com>
> >> ---
> >> Documentation/powerpc/booting-without-of.txt |   27 +++++
> >> arch/powerpc/sysdev/qe_lib/Kconfig           |    9 ++
> >> arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
> >> arch/powerpc/sysdev/qe_lib/gpio.c            |  148 +++++++++++++++++ 
> >> +++++++++
> >> include/asm-powerpc/qe.h                     |    2 +
> >> 5 files changed, 187 insertions(+), 0 deletions(-)
> >> create mode 100644 arch/powerpc/sysdev/qe_lib/gpio.c
> >
> > didn't we talk about putting this is drivers/gpio/ ?
> 
> :-)
> 
> Yes, we did. And David Brownell politely suggested to not do this,
> and instead leave it in arch/ as do all other arches for their SOC
> GPIOs.

Ping?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
