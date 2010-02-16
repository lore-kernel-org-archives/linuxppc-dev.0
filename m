Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2A0C4B7CC1
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 16:53:13 +1100 (EST)
Date: Mon, 15 Feb 2010 21:53:26 -0800 (PST)
Message-Id: <20100215.215326.250123543.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH] [V5] net: emaclite: adding MDIO and phy lib support
From: David Miller <davem@davemloft.net>
In-Reply-To: <fa686aa41002111440x699b6b1ck97b14002ee9fe7b1@mail.gmail.com>
References: <38677d6a-3f33-483c-8fbe-5f5c46d70140@VA3EHSMHS027.ehs.local>
	<fa686aa41002111440x699b6b1ck97b14002ee9fe7b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: Sadanand.Mutyala@xilinx.com, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com, john.linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Feb 2010 15:40:24 -0700

> On Thu, Feb 11, 2010 at 3:12 PM, John Linn <john.linn@xilinx.com> wro=
te:
>> These changes add MDIO and phy lib support to the driver as the
>> IP core now supports the MDIO bus.
>>
>> The MDIO bus and phy are added as a child to the emaclite in the dev=
ice
>> tree as illustrated below.
>>
>> mdio {
>> =A0 =A0 =A0 =A0#address-cells =3D <1>;
>> =A0 =A0 =A0 =A0#size-cells =3D <0>;
>> =A0 =A0 =A0 =A0phy0: phy@7 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "marvell,88e1111";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <7>;
>> =A0 =A0 =A0 =A0} ;
>> }
>>
>> Signed-off-by: Sadanand Mutyala <Sadanand.Mutyala@xilinx.com>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
> =

> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Applied.
