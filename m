Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 3CC86B6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 06:30:06 +1100 (EST)
Date: Wed, 1 Dec 2010 11:28:56 -0800
From: Greg KH <gregkh@suse.de>
To: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [PATCH] drivers: char: hvc: add arm JTAG DCC console support
Message-ID: <20101201192856.GA731@suse.de>
References: <1291145141-18301-1-git-send-email-dwalker@codeaurora.org>
	<4CF5DD63.40803@codeaurora.org>
	<1291229696.14404.39.camel@c-dwalke-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291229696.14404.39.camel@c-dwalke-linux.qualcomm.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Mike Frysinger <vapier@gentoo.org>,
	Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
	Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org,
	Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 01, 2010 at 10:54:56AM -0800, Daniel Walker wrote:
> On Tue, 2010-11-30 at 21:30 -0800, Stephen Boyd wrote:
> > On 11/30/2010 11:25 AM, Daniel Walker wrote:
> > > @@ -682,6 +682,15 @@ config HVC_UDBG
> > >         select HVC_DRIVER
> > >         default n
> > >  
> > > +config HVC_DCC
> > > +       bool "ARM JTAG DCC console"
> > > +       depends on ARM
> > > +       select HVC_DRIVER
> > > +       help
> > > +         This console uses the JTAG DCC on ARM to create a console under the HVC
> > 
> > Looks like you added one too many spaces for indent here.
> 
> The first line is fine, but the other two might need an extra space.

For this, or any other changes you want, I'll gladly take a follow-on
patch as this one is already in my tty-next tree.

thanks,

greg k-h
