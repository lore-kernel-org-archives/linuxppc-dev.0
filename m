Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08399B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 12:04:25 +1000 (EST)
Received: from mail80-ch1 (localhost.localdomain [127.0.0.1])	by
	mail80-ch1-R.bigfish.com (Postfix) with ESMTP id E6BFF1A044C	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2011 02:04:18 +0000 (UTC)
Received: from CH1EHSMHS032.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.250])	by mail80-ch1.bigfish.com (Postfix) with ESMTP id
	C8B451498050	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 02:04:18 +0000 (UTC)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: RE: [PATCH 1/4] powerpc/85xx: fix interrupt number of
	memory-controller for P4080
Date: Fri, 22 Jul 2011 02:04:10 +0000
Message-ID: <267A3B246C22C34A8E574051858E077010E0F7@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
	<65C49D37-A103-494D-AD8E-7C8FC6E3716E@freescale.com>
In-Reply-To: <65C49D37-A103-494D-AD8E-7C8FC6E3716E@freescale.com>
Content-Type: text/plain; charset="us-ascii"
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




>-----Original Message-----
>From: Gala Kumar-B11780
>Sent: Thursday, July 21, 2011 8:13 PM
>To: Xie Shaohui-B21989
>Cc: linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH 1/4] powerpc/85xx: fix interrupt number of memory-
>controller for P4080
>
>
>On Jul 21, 2011, at 5:24 AM, Shaohui Xie wrote:
>
>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>> ---
>> arch/powerpc/boot/dts/p4080ds.dts |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/p4080ds.dts
>b/arch/powerpc/boot/dts/p4080ds.dts
>> index 927f94d..9c37a85 100644
>> --- a/arch/powerpc/boot/dts/p4080ds.dts
>> +++ b/arch/powerpc/boot/dts/p4080ds.dts
>> @@ -131,14 +131,14 @@
>> 			compatible =3D "fsl,p4080-memory-controller";
>> 			reg =3D <0x8000 0x1000>;
>> 			interrupt-parent =3D <&mpic>;
>> -			interrupts =3D <0x12 2>;
>> +			interrupts =3D <16 2>;
>> 		};
>>
>> 		memory-controller@9000 {
>> 			compatible =3D "fsl,p4080-memory-controller";
>> 			reg =3D <0x9000 0x1000>;
>> 			interrupt-parent =3D <&mpic>;
>> -			interrupts =3D <0x12 2>;
>> +			interrupts =3D <16 2>;
>> 		};
>>
>> 		corenet-cf@18000 {
>> --
>> 1.6.4
>
>What code base / tree is this against?
>

[Xie Shaohui] This patch is based on v3.0-rc7.


Best Regards,=20
Shaohui Xie
