Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACE0E1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Jul 2011 08:08:41 +1000 (EST)
Date: Fri, 8 Jul 2011 15:06:54 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: tty/powerpc: introduce the ePAPR embedded hypervisor byte
	channel driver
Message-ID: <20110708220654.GA19146@kroah.com>
References: <1305830092-20104-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305830092-20104-1-git-send-email-timur@freescale.com>
Cc: arnd@arndb.de, kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	akpm@kernel.org, linux-console@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 08:34:52AM -0000, Timur Tabi wrote:
> The ePAPR embedded hypervisor specification provides an API for "byte
> channels", which are serial-like virtual devices for sending and receiving
> streams of bytes.  This driver provides Linux kernel support for byte
> channels via three distinct interfaces:
> 
> 1) An early-console (udbg) driver.  This provides early console output
> through a byte channel.  The byte channel handle must be specified in a
> Kconfig option.
> 
> 2) A normal console driver.  Output is sent to the byte channel designated
> for stdout in the device tree.  The console driver is for handling kernel
> printk calls.
> 
> 3) A tty driver, which is used to handle user-space input and output.  The
> byte channel used for the console is designated as the default tty.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Doesn't apply at all to the tty-next tree, so I can't apply it here :(
