Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 785B8B7224
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2012 02:25:13 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: acrux <acrux_it@libero.it>
Subject: Re: Efika (mpc5200b): sound doesn't build/work from linux-2.6.38.x
Date: Sun, 5 Feb 2012 15:25:00 +0000
Message-ID: <CAOZdJXVJdb0NsXQO-Dw4uT50B6eCCDLVGgALyP9oACACv0aXuA@mail.gmail.com>
References: <20120202034803.2fb7690b.acrux_it@libero.it>
 <20120202175751.2c6e4bb9.acrux_it@libero.it>
 <CAOZdJXU+kiQgsM9F3JVG3o8LV4oejSA1D85bFX+ZsqB7f9j_Ew@mail.gmail.com>
 <20120204030207.0d5cec19.acrux_it@libero.it>
In-Reply-To: <20120204030207.0d5cec19.acrux_it@libero.it>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 3, 2012 at 8:02 PM, acrux <acrux_it@libero.it> wrote:

> as i said [1] it seems to be fixed only in 3.x instead the last working o=
ne is the obsolete 2.6.36.x .
> Anyway, alog the sound/soc/fsl/mpc5200_dma.c now builds the sound is stil=
l broken.

Ok, I missed that part in your email.

The Efika sound driver was not being compiled by default for a very
long time, so I think everyone just forgot about it.  I posted a patch
to enable it by default and fix the compilation errors, but I'm pretty
sure that it's succumbed to bit rot.  ALSA has changed, especially
with the introduction of device trees, and so now someone needs to fix
the Efika driver.

--=20
Timur Tabi
Linux kernel developer at Freescale=
