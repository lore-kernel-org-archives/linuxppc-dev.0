Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17939.19585.475192.767243@cargo.ozlabs.ibm.com>
Date: Wed, 4 Apr 2007 16:58:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <1175642916.10567.24.camel@shinybook.infradead.org>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> A GUI PPP dialer should be
> listing the available serial ports in the system whatever their names
> are.

How do you propose they do that?  Neither kppp nor gnome-ppp seem to
be able to do that currently.  Gnome-ppp offers just /dev/modem and
/dev/ttyS[0123].  Kppp offers those plus a whole pile of others, but
neither found the /dev/ttyPZ[01] that I get with your patch applied.
Gnome-ppp at least let me type in /dev/ttyPZ0, but kppp didn't seem to
have that facility.

> And nobody _forces_ you to use the name ttyPZ0. If you really want, you
> can call it ttyS0.... just mknod /dev/ttyS0 204 192

Sure I can do that, but that's beyond a non-technical user, who is
precisely the person who won't know (and shouldn't have to know) that
their computer has an 85C30 chip rather than a 16C550, or even what
those numbers refer to.

Paul.
