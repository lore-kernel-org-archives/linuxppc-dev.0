Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 03879DDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 03:38:40 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Date: Fri, 29 Aug 2008 19:38:25 +0200
References: <Pine.LNX.4.44L0.0808291307050.4447-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0808291307050.4447-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808291938.26651.arnd@arndb.de>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
	Scott Wood <scottwood@freescale.com>, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 August 2008, Alan Stern wrote:
> I thought you _were_ arguing against that. =A0Unless I misunderstood,
> your original complaint was that since each peripheral controller
> driver defines usb_gadget_{un}register_driver, there can be only one
> controller driver loaded at a time.

That's probably where the misunderstanding came from: I did not expect
more than one driver to actually be useful on a given system, but that
should IMHO not prevent you from loading the drivers using modprobe, or
building them all into the kernel.

	Arnd <><
