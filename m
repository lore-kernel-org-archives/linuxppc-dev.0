Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 4A2A9DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 00:40:47 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id B6745F491A9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 14:40:44 +0100 (CET)
Subject: Re: [PATCH] using mii-bitbang on different processor ports -
	update the booting-without-of.txt-file
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071106184649.GA5283@loki.buserror.net>
References: <1194339117.3467.8.camel@p60635-ste.ids.de>
	<20071106184649.GA5283@loki.buserror.net>
Date: Wed, 07 Nov 2007 14:40:44 +0100
Message-Id: <1194442844.3571.14.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Dienstag, den 06.11.2007, 12:46 -0600 schrieb Scott Wood:
> >  
> > +   The "reg"-property may have also depending on board design
> > +   the following form:
> > +	reg = <10d40 14 10d60 14>;
> > +   In that case the pin for mdio data controlling is on the port C,
> > +   and the pin for mdio clock controlling is on the port D.
> 
> It'd be better to explicitly say that the first resource is mdio, and the
> second resource is mdc, rather than require the reader to know/look up which
> corresponds to 10d40 and which to 10d60.
> 
> -Scott

Ok. What would you say about something like that:
--
If both mdio and mdc controlling pins are on the same processor port,
one resource should be used.
Otherwise, two resources are used: the 1-st - mdio, the 2-nd - mdc.
--
Please, correct me, if it sounds bad.

Thanks and regards
Sergej. 
