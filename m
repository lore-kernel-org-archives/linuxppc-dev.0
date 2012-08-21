Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 058952C007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 11:22:44 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when missing USB PHY
 clock
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <3F453DDFF675A64A89321A1F3528102178AD97@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Mon, 20 Aug 2012 20:22:35 -0500
Message-Id: <9F42EE26-7362-4B6E-8BD6-92EE02A07A1D@kernel.crashing.org>
References: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1344595712-12804-2-git-send-email-Shengzhou.Liu@freescale.com>
 <366E392A-9EAE-43C9-8666-808EA19C03EA@kernel.crashing.org>
 <3F453DDFF675A64A89321A1F3528102178AD97@039-SN1MPN1-004.039d.mgd.msft.net>
To: gregkh@linuxfoundation.org
Cc: Liu Shengzhou-B36685 <B36685@freescale.com>, linux-usb@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2012, at 10:01 PM, Liu Shengzhou-B36685 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Friday, August 10, 2012 9:50 PM
>> To: Liu Shengzhou-B36685
>> Cc: linuxppc-dev@lists.ozlabs.org list; linux-usb@vger.kernel.org;
>> gregkh@linuxfoundation.org
>> Subject: Re: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when =
missing USB PHY
>> clock
>>=20
>>=20
>> On Aug 10, 2012, at 5:48 AM, Shengzhou Liu wrote:
>>=20
>>> when missing USB PHY clock, kernel booting up will hang during USB
>>> initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid =
CPU
>>> hanging in this case.
>>>=20
>>> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>>> ---
>>> drivers/usb/host/ehci-fsl.c |   63 =
++++++++++++++++++++++++++++++-----------
>> -
>>> drivers/usb/host/ehci-fsl.h |    1 +
>>> 2 files changed, 46 insertions(+), 18 deletions(-)
>>=20
>> I assume this should be considered a bug fix and be looked at for =
inclusion in
>> v3.6?
>>=20
>> - k
> [Shengzhou] Yes.=20

Greg,

ping?

- k
