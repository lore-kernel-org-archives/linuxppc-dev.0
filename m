Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E9A7F68926
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 21:35:49 +1100 (EST)
Subject: Re: Fw:   therm_adm103x: inquiry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17351.28085.401798.395945@cargo.ozlabs.ibm.com>
References: <20060112215200.680a8cc1.cedric.pradalier@free.fr>
	<17351.28085.401798.395945@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 13 Jan 2006 21:35:36 +1100
Message-Id: <1137148536.4862.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Cedric Pradalier <cedric.pradalier@free.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-01-13 at 20:07 +1100, Paul Mackerras wrote:
> Cedric Pradalier writes:
> 
> > As far as I can see, this module seems mature enough for
> > inclusion in official kernel.
> > 
> > A tested patch against 2.6.14 is available at:
> > http://cedric.pradalier.free.fr/ibook2/adm103x-2.6.14.diff.gz
> > 
> > I've not tested it yet for 2.6.15. 
> > 
> > Some details, from the link site above:
> > 
> > The module provides and sysfs access to the adm103x fan
> > control parameters. For instance
> > 
> > 	  #cat /sys/device/temperatures/info? 
> > 	  T:51°C S:56°C R:10°C  <-- sensor 0
> > 	  T:48°C S:76°C R:10°C  <-- sensor 1
> 
> I think we should remove the degree symbol, since it is neither ASCII
> nor UTF-8, and it is unnecessary.  Apart from that it sounds OK; we
> would have to see the code before deciding whether to include it.

Cedric, you should post the patch directly inline with the mail, with
the proper description and Signed-off-by line.

Ben.
