Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DC2CBB6F68
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 22:38:49 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: Re: [PATCH] powerpc/usb: use unsigned long to type cast an address
 of ioremap
Date: Thu, 3 Nov 2011 11:38:39 +0000
Message-ID: <CAOZdJXW16RbPkMfmoNu4t1c5mqCuZsztPMk1=hNc7NaYXOsx7A@mail.gmail.com>
References: <1320314302-7973-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1320314302-7973-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 3, 2011 at 4:58 AM, Shaohui Xie <Shaohui.Xie@freescale.com> wro=
te:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_sys_regs =3D (struct usb_sys_interface=
 *)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((u32)dr_re=
gs + USB_DR_SYS_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned =
long)dr_regs + USB_DR_SYS_OFFSET);

This makes more sense:

usb_sys_regs =3D (void *)dr_regs + USB_DR_SYS_OFFSET;

--=20
Timur Tabi
Linux kernel developer at Freescale=
