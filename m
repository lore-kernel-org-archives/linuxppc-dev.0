Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 358ADB6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Jul 2011 11:44:02 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "greg@kroah.com" <greg@kroah.com>
Subject: Re: [PATCH 6/7] [v2] tty/powerpc: introduce the ePAPR embedded
	hypervisor byte channel driver
Date: Sun, 3 Jul 2011 01:43:52 +0000
Message-ID: <CAOZdJXVyujA0fsnvYnCcqDYhmgYMk0DwBTh-wEkFN4fCDVYdcA@mail.gmail.com>
References: <1305830092-20104-1-git-send-email-timur@freescale.com>
In-Reply-To: <1305830092-20104-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@kernel.org" <akpm@kernel.org>,
	"linux-console@vger.kernel.org" <linux-console@vger.kernel.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 1:34 PM, Timur Tabi <timur@freescale.com> wrote:
> The ePAPR embedded hypervisor specification provides an API for "byte
> channels", which are serial-like virtual devices for sending and receivin=
g
> streams of bytes. =A0This driver provides Linux kernel support for byte
> channels via three distinct interfaces:
>
> 1) An early-console (udbg) driver. =A0This provides early console output
> through a byte channel. =A0The byte channel handle must be specified in a
> Kconfig option.
>
> 2) A normal console driver. =A0Output is sent to the byte channel designa=
ted
> for stdout in the device tree. =A0The console driver is for handling kern=
el
> printk calls.
>
> 3) A tty driver, which is used to handle user-space input and output. =A0=
The
> byte channel used for the console is designated as the default tty.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Greg, would you please pick up this patch for 3.1?  Patches 1-5 are
already queued through the PowerPC tree.

Thank you.

The patch is available here if you need to download it:
http://patchwork.ozlabs.org/patch/96443/

--=20
Timur Tabi
Linux kernel developer at Freescale=
