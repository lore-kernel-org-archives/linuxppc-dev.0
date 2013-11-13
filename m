Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C79B92C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 18:33:14 +1100 (EST)
Date: Wed, 13 Nov 2013 08:32:59 +0100
From: Anatolij Gustschin <agust@denx.de>
To: neorf3k <neorf3k@gmail.com>
Subject: Re: Problem reading and programming memory location...
Message-ID: <20131113083259.1b69ed18@crub>
In-Reply-To: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux Ppc Dev List Dev List <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Nov 2013 20:23:20 +0100
neorf3k <neorf3k@gmail.com> wrote:

> we have tried to read and program an 8bit register with 32bit address.
> we have mapped it with: ioremap, kmalloc etc=E2=80=A6 and then using: out=
b,
> iowrite8 etc.. but when we write to it, the value doesn=E2=80=99t change=
=E2=80=A6
> with other memory location is ok.
> That is an 8 bit register, located at 0x10020000 in a mpc5200b
> architecture. we are using kernel 2.6.33.=20
> what could be?

0x10020000 is not in the internal register memory map, so it
is probably a device on the LocalPlus bus. Did you configure
the chip select parameters for this device and did you enable
the associated chip select?
 =20
HTH,

Anatolij
