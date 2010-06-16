Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 65E9A1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 00:24:11 +1000 (EST)
Received: by vws6 with SMTP id 6so355152vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 07:24:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C189860.3040702@neli.hopto.org>
References: <4C187616.4000303@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
	<4C189860.3040702@neli.hopto.org>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Wed, 16 Jun 2010 09:23:38 -0500
Message-ID: <AANLkTikDywS1B5i2kCQfTvJAWBuq7K3UuOmGQzi45UAX@mail.gmail.com>
Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
To: Micha Nelissen <micha@neli.hopto.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 16, 2010 at 4:24 AM, Micha Nelissen <micha@neli.hopto.org> wrote:

> IMHO:
> 1) Linux should not be dependent on U-boot or any other bootloader, or at
> least as possible
> 2) U-boot cannot (and does not want to) know whether Linux is going to use
> large physical addresses.

To quote The Dude: "Yeah, well, you know, that's just, like, your opinion, man."

I'm sorry, but Linux does depend on the boot loader, and U-Boot does
need to know whether Linux is going to use 36-bit addressing.  That's
just the way it works.  Linux patches that repeat what U-Boot already
does just so that you don't need to update your U-boot are going to be
rejected.

-- 
Timur Tabi
Linux kernel developer at Freescale
