Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B53812C0195
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 06:14:01 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860 and B4420
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <E12D2F89F87F4A49B0320A4C2DE7E749151B18@039-SN2MPN1-011.039d.mgd.msft.net>
Date: Thu, 4 Apr 2013 14:13:38 -0500
Message-Id: <E3681803-00AE-4FBD-8BEA-E32C18F71A7E@kernel.crashing.org>
References: <1364886968-9634-1-git-send-email-shaveta@freescale.com>
 <2E7EAABC-5A34-46D2-B4C8-80081AC1563F@kernel.crashing.org>
 <E12D2F89F87F4A49B0320A4C2DE7E749151B18@039-SN2MPN1-011.039d.mgd.msft.net>
To: Leekha Shaveta-B20052 <B20052@freescale.com>
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 Mehresh Ramneek-B31383 <B31383@freescale.com>,
 Garg Vakul-B16394 <B16394@freescale.com>,
 Lian Minghuan-B31939 <B31939@freescale.com>,
 Tang Yuantian-B29983 <B29983@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 4, 2013, at 2:10 AM, Leekha Shaveta-B20052 wrote:

>=20
>=20
> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, April 03, 2013 10:10 PM
> To: Leekha Shaveta-B20052
> Cc: linuxppc-dev@lists.ozlabs.org; Zhao Chenhui-B35336; Li =
Yang-R58472; Tang Yuantian-B29983; Sethi Varun-B16395; Lian =
Minghuan-B31939; Mehresh Ramneek-B31383; Fleming Andy-AFLEMING; Garg =
Vakul-B16394
> Subject: Re: [PATCH 2/5] powerpc/fsl-booke: Add initial silicon device =
tree files for B4860 and B4420
>=20
>=20
> On Apr 2, 2013, at 2:16 AM, Shaveta Leekha wrote:
>=20
>> B4860 and B4420 are similar that share some commonalities
>>=20
>> * common features have been added in b4si-pre.dtsi and b4si-post.dtsi
>> * differences are added in respective silicon files of B4860 and =
B4420
>=20
> What are the differences between B4860 & B4420, beyond # of cores?
> [SL] have detailed the differences in board support patch sent in this =
patch set.
> Do I need to mention the differences here also?=20
>=20
>>=20
>> There are several things missing from the device trees of B4860 and =
B4420:
>>=20
>> * DPAA related nodes (Qman, Bman, Fman, Rman)
>> * DSP related nodes/information
>=20
> What about:
>=20
> serdes, sfp [security fuse processor], thermal, gpio, maple, cpri, =
quad timers,=20
> [SL] I would prefer to add, what have been added in device tree so far =
in patch description
> As that is clear to me.
> But as u suggested, I mentioned some of the nodes/things missing, =
though the list is not
> Exhaustive. Also I am not sure of, what would be added/required in =
future in these device tree files.
>=20
> Anyways, I can add all the things you have mentioned above.
> Please tell if anything else is missing.

I would add the trivial ones and just make sure the list is exhaustive =
for the ones missing in the commit message.

>=20
> Regards,
> Shaveta
>=20
>>=20
>> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
>> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> Signed-off-by: Andy Fleming <afleming@freescale.com>
>> Signed-off-by: Vakul Garg <vakul@freescale.com>
>> ---
>> arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |   94 ++++++++++
>> arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   49 +++++
>> arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  138 ++++++++++++++
>> arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   59 ++++++
>> arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  262 =
+++++++++++++++++++++++++++
>> arch/powerpc/boot/dts/fsl/b4si-pre.dtsi     |   65 +++++++
>=20
> Remove b4si-pre.dtsi, there isn't enough here to warrant not just =
merging it into b4420si-pre.dtsi & b4860si-pre.dtsi
>=20

- k
