Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2E90DDEEB
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 00:16:32 +1000 (EST)
Subject: Re: [PATCH / RFC] net: don't grab a mutex within a timer context
	in gianfar
From: Nate Case <ncase@xes-inc.com>
To: Sebastian Siewior <netdev@ml.breakpoint.cc>
In-Reply-To: <20080723200337.GA5122@Chamillionaire.breakpoint.cc>
References: <20080718121008.GA28871@Chamillionaire.breakpoint.cc>
	<1216681028.7559.993.camel@localhost.localdomain>
	<20080722205911.GA29840@Chamillionaire.breakpoint.cc>
	<20080723200337.GA5122@Chamillionaire.breakpoint.cc>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 09:16:00 -0500
Message-Id: <1216995360.7559.1022.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Vitaly Bordug <vbordug@ru.mvista.com>,
	Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-23 at 22:03 +0200, Sebastian Siewior wrote:
> I moved it into a workqueue, this is what tg3 does.
> I would convert the other three drivers unless $dude suggests a better
> method or somebody else takes care....
> 
>  drivers/net/gianfar.c |   22 ++++++++++++++++++----
>  drivers/net/gianfar.h |    2 ++
>  2 files changed, 20 insertions(+), 4 deletions(-)

This looks good to me.

-- 
Nate Case <ncase@xes-inc.com>
