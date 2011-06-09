Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1BAF7B6F8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 06:47:00 +1000 (EST)
Subject: Re: [PATCH] ppc/85xx: specify interrupt for pq3-localbus devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
In-Reply-To: <BANLkTin=bz=+_Tmhm7++PWY3WHWDFpumNg@mail.gmail.com>
References: <1306941318-5771-1-git-send-email-dbaryshkov@gmail.com>
	<BANLkTin=bz=+_Tmhm7++PWY3WHWDFpumNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Jun 2011 06:46:52 +1000
Message-ID: <1307652412.2874.276.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-06-09 at 19:01 +0400, Dmitry Eremin-Solenikov wrote:
> Sorry, if I'm being too noisy, what about this patch?

Just wait til somebody has a chance to pick it up. I have been too busy
lately and it looks like others as well. It shouldn't get lost, it's
tracked on patchwork.

Cheers,
Ben.

> On 6/1/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> > fsl-lbc driver requires an interrupt to bind to localbus device.
> > Populate 85xx boards' dts trees with lbc interrupt info.
> >
> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > ---
> >  arch/powerpc/boot/dts/mpc8568mds.dts       |    2 ++
> >  arch/powerpc/boot/dts/socrates.dts         |    2 ++
> >  arch/powerpc/boot/dts/tqm8540.dts          |    2 ++
> >  arch/powerpc/boot/dts/tqm8548-bigflash.dts |    2 ++
> >  arch/powerpc/boot/dts/tqm8548.dts          |    2 ++
> >  arch/powerpc/boot/dts/tqm8560.dts          |    2 ++
> >  arch/powerpc/boot/dts/xpedite5200.dts      |    2 ++
> >  arch/powerpc/boot/dts/xpedite5200_xmon.dts |    2 ++
> >  8 files changed, 16 insertions(+), 0 deletions(-)
> 
> 
