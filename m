Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CBC02C007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2012 03:46:13 +1100 (EST)
Date: Fri, 30 Nov 2012 10:45:31 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: fsl spi questions & patch
To: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
References: <CACW_hTa4eVOfxKus1ma8vB6dVZu4PovasLtn=+7UygqYtC_Vww@mail.gmail.com>
In-Reply-To: <CACW_hTa4eVOfxKus1ma8vB6dVZu4PovasLtn=+7UygqYtC_Vww@mail.gmail.com>
 (from fransmeulenbroeks@gmail.com on Wed Nov 28 03:39:22 2012)
Message-ID: <1354293931.16659.13@tyr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/28/2012 03:39:22 AM, Frans Meulenbroeks wrote:
> Hi,
>=20
> I've been playing with spi on mpc8313e and have some things on
> spi-fsl-spi.c:
>=20
> Is QE useful on 8313?
> I've tried it (using cpu-qe in my dts file) and see in the boot log =20
> that it
> is used, but I do not really see any effect when it comes to =20
> performance or
> cpu usage.

8313 does not have a QE.  The "effect" when you do have a QE and use it =20
is that you can talk to the peripherals that are connected to the QE.  =20
The effect when you modify the device tree to say the board has =20
hardware that it doesn't have is generally bad.

-Scott=
