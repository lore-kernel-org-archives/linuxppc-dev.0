Return-Path: <greg@kroah.com>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0D461007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Sep 2011 09:08:50 +1000 (EST)
Date: Thu, 22 Sep 2011 16:08:44 -0700
From: Greg KH <greg@kroah.com>
To: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [PATCH 54/62] TTY: irq: Remove IRQF_DISABLED
Message-ID: <20110922230844.GA17025@kroah.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-55-git-send-email-yong.zhang0@gmail.com>
	<20110922230420.GA11264@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110922230420.GA11264@kroah.com>
Cc: nios2-dev@sopc.et.ntust.edu.tw, Jesper Nilsson <jesper.nilsson@axis.com>,
	linux-cris-kernel@axis.com, Tobias Klauser <tklauser@distanz.ch>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Mikael Starvik <starvik@axis.com>,
	Jesper Juhl <jj@chaosbits.net>, linux-serial@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	uclinux-dist-devel@blackfin.uclinux.org, tglx@linutronix.de,
	Sonic Zhang <sonic.zhang@analog.com>,
	linuxppc-dev@lists.ozlabs.org, mingo@elte.hu,
	Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2011 at 04:04:20PM -0700, Greg KH wrote:
> On Wed, Sep 07, 2011 at 04:10:51PM +0800, Yong Zhang wrote:
> > This flag is a NOOP and can be removed now.
> > 
> > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > Acked-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  drivers/tty/amiserial.c              |    2 +-
> >  drivers/tty/cyclades.c               |    2 +-
> >  drivers/tty/hvc/hvc_irq.c            |    2 +-
> >  drivers/tty/hvc/hvcs.c               |    2 +-
> >  drivers/tty/hvc/hvsi.c               |    2 +-
> >  drivers/tty/isicom.c                 |    2 +-
> >  drivers/tty/serial/68328serial.c     |    2 +-
> >  drivers/tty/serial/altera_jtaguart.c |    2 +-
> >  drivers/tty/serial/altera_uart.c     |    2 +-
> >  drivers/tty/serial/bfin_5xx.c        |    8 ++++----
> 
> This file isn't in my tree anymore, so I can't apply this :(
> 

Oh nevermind, I see your newer patch, I'll take that one, sorry.

greg k-h
