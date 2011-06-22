Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70F70B6FC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 01:23:45 +1000 (EST)
Message-ID: <4E0208F4.4030800@freescale.com>
Date: Wed, 22 Jun 2011 10:23:32 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: <kumar.gala@freescale.com>, <benh@kernel.crashing.org>, <greg@kroah.com>,
	<akpm@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-console@vger.kernel.org>,
	<alan@lxorguk.ukuu.org.uk>, <arnd@arndb.de>
Subject: Re: [PATCH 6/7] [v2] tty/powerpc: introduce the ePAPR embedded
	hypervisor byte channel driver
References: <1305830092-20104-1-git-send-email-timur@freescale.com>
In-Reply-To: <1305830092-20104-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
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

I know you guys are busy, but can I get an ACK or two on this patch, if there
are no issues with it?  It's the only one of the seven that doesn't have one.  I
think v2 has addressed all of the concerns raised on version 1.

-- 
Timur Tabi
Linux kernel developer at Freescale
