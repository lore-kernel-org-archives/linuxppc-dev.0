Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B9BCB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 20:10:11 +1000 (EST)
Received: from mail23-va3 (localhost.localdomain [127.0.0.1])	by
	mail23-va3-R.bigfish.com (Postfix) with ESMTP id 1AE7B1080330	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2011 10:10:06 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.247])	by
	mail23-va3.bigfish.com (Postfix) with ESMTP id F2F2ECE8083	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2011 10:10:05 +0000 (UTC)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: RE: [PATCH 2/4] powerpc/85xx: enable pcie initialization for P4080
Date: Fri, 22 Jul 2011 10:09:53 +0000
Message-ID: <267A3B246C22C34A8E574051858E077010E32F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1311243914-4349-1-git-send-email-Shaohui.Xie@freescale.com>
	<D08A7FEC-DF4F-4EF3-B064-13E91242EF91@freescale.com>
In-Reply-To: <D08A7FEC-DF4F-4EF3-B064-13E91242EF91@freescale.com>
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
>Sent: Friday, July 22, 2011 2:06 PM
>To: Xie Shaohui-B21989
>Cc: linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH 2/4] powerpc/85xx: enable pcie initialization for
>P4080
>
>
>On Jul 21, 2011, at 5:25 AM, Shaohui Xie wrote:
>
>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>> ---
>> arch/powerpc/platforms/85xx/corenet_ds.c |    3 +++
>> 1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c
>b/arch/powerpc/platforms/85xx/corenet_ds.c
>> index 2ab338c..15247b0 100644
>> --- a/arch/powerpc/platforms/85xx/corenet_ds.c
>> +++ b/arch/powerpc/platforms/85xx/corenet_ds.c
>> @@ -114,6 +114,9 @@ static const struct of_device_id of_device_ids[]
>__devinitconst =3D {
>> 		.compatible	=3D "simple-bus"
>> 	},
>> 	{
>> +		.compatible	=3D "fsl,p4080-pcie"
>> +	},
>> +	{
>> 		.compatible	=3D "fsl,rapidio-delta",
>> 	},
>> 	{}
>> --
>> 1.6.4
>>
>
>What about p204x, p3041 & p5020 boards?
>

[Xie Shaohui] I've check the galak/powerpc.git 'next' branch, this patch is=
 not needed, please ignore it.


Best Regards,=20
Shaohui Xie
