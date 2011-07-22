Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85DB7B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 16:01:00 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc/85xx: fix interrupt number of
	memory-controller for P4080
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <267A3B246C22C34A8E574051858E077010E0F7@039-SN1MPN1-003.039d.mgd.msft.net>
Date: Fri, 22 Jul 2011 01:00:48 -0500
Message-Id: <D1A417CC-2514-4103-8D0E-96F16724BCEF@kernel.crashing.org>
References: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
	<65C49D37-A103-494D-AD8E-7C8FC6E3716E@freescale.com>
	<267A3B246C22C34A8E574051858E077010E0F7@039-SN1MPN1-003.039d.mgd.msft.net>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2011, at 9:04 PM, Xie Shaohui-B21989 wrote:

>=20
>=20
>=20
>> -----Original Message-----
>> From: Gala Kumar-B11780
>> Sent: Thursday, July 21, 2011 8:13 PM
>> To: Xie Shaohui-B21989
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH 1/4] powerpc/85xx: fix interrupt number of =
memory-
>> controller for P4080
>>=20
>>=20
>> On Jul 21, 2011, at 5:24 AM, Shaohui Xie wrote:
>>=20
>>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>> ---
>>> arch/powerpc/boot/dts/p4080ds.dts |    4 ++--
>>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/boot/dts/p4080ds.dts
>> b/arch/powerpc/boot/dts/p4080ds.dts
>>> index 927f94d..9c37a85 100644
>>> --- a/arch/powerpc/boot/dts/p4080ds.dts
>>> +++ b/arch/powerpc/boot/dts/p4080ds.dts
>>> @@ -131,14 +131,14 @@
>>> 			compatible =3D "fsl,p4080-memory-controller";
>>> 			reg =3D <0x8000 0x1000>;
>>> 			interrupt-parent =3D <&mpic>;
>>> -			interrupts =3D <0x12 2>;
>>> +			interrupts =3D <16 2>;
>>> 		};
>>>=20
>>> 		memory-controller@9000 {
>>> 			compatible =3D "fsl,p4080-memory-controller";
>>> 			reg =3D <0x9000 0x1000>;
>>> 			interrupt-parent =3D <&mpic>;
>>> -			interrupts =3D <0x12 2>;
>>> +			interrupts =3D <16 2>;
>>> 		};
>>>=20
>>> 		corenet-cf@18000 {
>>> --
>>> 1.6.4
>>=20
>> What code base / tree is this against?
>>=20
>=20
> [Xie Shaohui] This patch is based on v3.0-rc7.

Please use galak/powerpc.git 'next' branch.

It has the following:

=
http://git.kernel.org/?p=3Dlinux/kernel/git/galak/powerpc.git;a=3Dblob;f=3D=
arch/powerpc/boot/dts/p4080si.dtsi;h=3Db71051f506c1763fbb911a0df62b58577ed=
a2ce0;hb=3Drefs/heads/next

- k=
