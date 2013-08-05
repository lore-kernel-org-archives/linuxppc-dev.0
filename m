Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E88152C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 04:26:08 +1000 (EST)
Date: Mon, 5 Aug 2013 20:25:59 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Re: Failure to detect PCI card
Message-ID: <20130805202559.0086e806@crub>
In-Reply-To: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 5 Aug 2013 10:58:01 -0700
Peter LaDow <petela@gocougs.wsu.edu> wrote:

> I have a PCI card (a Netgear FA331, vendor:device 100b:0020) that is
> failing to be detected by our PPC platform.  This device works just
> fine in a PC, and other cards work just fine in the same PCI slot (we
> have an Intel 82540EM based card that works).
> 
> But for some reason, neither u-boot nor the kernel detect this card.
> Any ideas why this might be?

Maybe this card needs bigger delay to respond after PCI reset. You can
try to re-build U-Boot with defined CONFIG_PCI_BOOTDELAY. Use 1000
for CONFIG_PCI_BOOTDELAY in the first step and if detection works,
try to decrease this value.

HTH,

Anatolij
