Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 977E9B6F70
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 23:07:29 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] powerpc/usb: use unsigned long to type cast an address
 of ioremap
Date: Thu, 3 Nov 2011 12:07:19 +0000
Message-ID: <4EB283F5.6000202@freescale.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA3@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AEA3@saturn3.aculab.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight wrote:
>> >  usb_sys_regs =3D (void *)dr_regs + USB_DR_SYS_OFFSET;

> But that is invalid C.

What's invalid about it?  I haven't tried compiling this specific line of=20
code, but I've done stuff like it in the past many times.

Are you talking about adding an integer to a void pointer?  If so, then=20
that's something that gcc supports and that the kernel uses all over the=20
place.  A char* is incorrect because a char could be more than one byte,=20
in theory.

--=20
Timur Tabi
Linux kernel developer at Freescale=
