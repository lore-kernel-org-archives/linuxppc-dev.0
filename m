Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AA8CDE058
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 08:42:04 +1000 (EST)
Message-ID: <48B6E62D.4060606@freescale.com>
Date: Thu, 28 Aug 2008 12:53:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
References: <Pine.LNX.4.44L0.0808281320010.2464-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0808281320010.2464-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: dbrownell@users.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
	greg@kroah.com, linux-usb@vger.kernel.org,
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

Alan Stern wrote:
> This was done deliberately.  The relevant standards state that a USB
> device can have no more than one peripheral interface.

Does building a kernel image that can run on different hardware without 
rebuilding also violate the "relevant standards"?

And who's to say that there aren't multiple USB devices on a single 
board, that just happen to share a CPU and memory? :-)

-Scott
