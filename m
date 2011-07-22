Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66361B6F64
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jul 2011 05:01:10 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "greg@kroah.com" <greg@kroah.com>
Subject: Re: [PATCH] [v3] tty/powerpc: introduce the ePAPR embedded
	hypervisor byte channel driver
Date: Fri, 22 Jul 2011 19:00:40 +0000
Message-ID: <CAOZdJXVD6=UizQjgNK-rJm2hDpZG+Gupo6+M3wW-VS7O1rTo_Q@mail.gmail.com>
References: <1310169972-13756-1-git-send-email-timur@freescale.com>
In-Reply-To: <1310169972-13756-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-console@vger.kernel.org" <linux-console@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 8, 2011 at 7:06 PM, Timur Tabi <timur@freescale.com> wrote:
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
> ---

Greg,

I just want to make sure you haven't forgotten this patch.  Will you
be picking it up for 3.1?

--=20
Timur Tabi
Linux kernel developer at Freescale=
