Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id E77F11007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 00:55:20 +1000 (EST)
Message-ID: <4C18E545.30807@neli.hopto.org>
Date: Wed, 16 Jun 2010 16:52:53 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Timur Tabi <timur.tabi@gmail.com>,  linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
References: <4C187616.4000303@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
	<4C189860.3040702@neli.hopto.org>
	<AANLkTikDywS1B5i2kCQfTvJAWBuq7K3UuOmGQzi45UAX@mail.gmail.com>
In-Reply-To: <AANLkTikDywS1B5i2kCQfTvJAWBuq7K3UuOmGQzi45UAX@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> I'm sorry, but Linux does depend on the boot loader, and U-Boot does
> need to know whether Linux is going to use 36-bit addressing.  

Why?

> That's
> just the way it works. 

What a great design philosophy!

> Linux patches that repeat what U-Boot already
> does just so that you don't need to update your U-boot are going to be
> rejected.

Who said anything about not wanting/needing to upgrade U-boot?

Micha
