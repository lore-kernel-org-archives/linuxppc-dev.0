Return-Path: <SRS0+5a975b97460a6157554b+1319+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F66DDDE19
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 00:17:19 +1000 (EST)
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17939.19585.475192.767243@cargo.ozlabs.ibm.com>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<17939.19585.475192.767243@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 10:16:41 -0400
Message-Id: <1175696202.2774.20.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-04 at 16:58 +1000, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > A GUI PPP dialer should be
> > listing the available serial ports in the system whatever their names
> > are.
> 
> How do you propose they do that?  Neither kppp nor gnome-ppp seem to
> be able to do that currently.  Gnome-ppp offers just /dev/modem and
> /dev/ttyS[0123].  Kppp offers those plus a whole pile of others, but
> neither found the /dev/ttyPZ[01] that I get with your patch applied.
> Gnome-ppp at least let me type in /dev/ttyPZ0, but kppp didn't seem to
> have that facility.

shinybook /shiny/git/olpc-2.6 $ ls /dev/tty[a-zA-Z]* 
/dev/ttyPZ0  /dev/ttyPZ1  /dev/ttyS0  /dev/ttyS1  /dev/ttyS2  /dev/ttyS3

If you have dialler programs which can't manage to show you the existing
serial ports, file bugs. Especially if they don't let you type device
nodes into them. Sounds like kppp wouldn't let you use USB serial ports
either -- or phones connected directly via USB.

-- 
dwmw2
