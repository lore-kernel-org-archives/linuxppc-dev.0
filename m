Return-Path: <stern+48acf28e@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id B1774DE607
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 03:22:44 +1000 (EST)
Date: Thu, 28 Aug 2008 13:22:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
In-Reply-To: <200808281704.20999.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.0808281320010.2464-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Aug 2008, Arnd Bergmann wrote:

> Not addressing this driver in particular, but the USB gadget layer in
> general: This is a horrible interface, since every gadget driver exports
> the same symbols, you can never build a kernel that includes more than
> one gadget driver. Even if the drivers are all built as modules, simply
> loading one of them prevents loading another one.

This was done deliberately.  The relevant standards state that a USB
device can have no more than one peripheral interface.

Now, I don't claim to fully support this decision.  But there is a 
reason behind it; it's not just a case of bad design.

Alan Stern
