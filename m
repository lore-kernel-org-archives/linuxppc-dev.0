Return-Path: <stern+48acf28e@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 30469DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 07:22:54 +1000 (EST)
Date: Fri, 29 Aug 2008 17:22:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
In-Reply-To: <200808291938.26651.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.0808291722160.13185-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Aug 2008, Arnd Bergmann wrote:

> On Friday 29 August 2008, Alan Stern wrote:
> > I thought you _were_ arguing against that.  Unless I misunderstood,
> > your original complaint was that since each peripheral controller
> > driver defines usb_gadget_{un}register_driver, there can be only one
> > controller driver loaded at a time.
> 
> That's probably where the misunderstanding came from: I did not expect
> more than one driver to actually be useful on a given system, but that
> should IMHO not prevent you from loading the drivers using modprobe, or
> building them all into the kernel.

All right, then we're in agreement.  :-)

Alan Stern
