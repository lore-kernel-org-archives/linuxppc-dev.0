Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9EB612C0088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 00:47:22 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXX1+=p3GMccLvCwFpei2igidXuo_U1gSVy56cBAkKxoHg@mail.gmail.com>
Date: Wed, 11 Jul 2012 09:47:17 -0500
Message-Id: <4D91E39B-2773-429D-B956-38C04521C8B2@kernel.crashing.org>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
 <CAOZdJXX1+=p3GMccLvCwFpei2igidXuo_U1gSVy56cBAkKxoHg@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Xu Jiucheng-B37781 <B37781@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 7:25 AM, Tabi Timur-B04825 wrote:

> On Tue, Jul 10, 2012 at 3:39 AM, Xu Jiucheng =
<Jiucheng.Xu@freescale.com> wrote:
>> Create the dts files for each core and splits the devices between
>> the two cores for P1021RDB-PC.
>>=20
>> Core0 has l2, serial0, i2c, spi, gpio, tdm,dma, usb, eth0, eth1,
>> sdhc, crypto, global-util, message, pci0, pci1, msi, crypto.
>> Core1 has l2, serial1, eth2.
>>=20
>> Signed-off-by: Xu Jiucheng <Jiucheng.Xu@freescale.com>
>> Signed-off-by: Matthew McClintock <msm@freescale.com>
>> ---
>=20
> Do we really want AMP device trees upstream?  They're very
> application-specific, and AMP support has always been a hack.  If
> anything, I think we should be deleting AMP device trees from
> upstream, not adding more.

Since we already have P1021RDB-PC w/AMP support in upstream I agree we =
don't need another example on P1021RDB-PC.

- k=
