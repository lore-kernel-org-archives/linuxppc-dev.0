Return-Path: <B34182@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3CF2BB7200
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 14:22:03 +1100 (EST)
From: Liu Gang-B34182 <B34182@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 4/5, v3] powerpc/8xxx: Update device tree bus probe for
 new RapidIO node binding
Date: Tue, 15 Nov 2011 03:21:54 +0000
Message-ID: <9A1C2A9ACC704641BC472A1588CE16471417AE@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-4-git-send-email-Gang.Liu@freescale.com>
 <4EC15145.3030001@freescale.com> <4EC151D5.3040900@freescale.com>
In-Reply-To: <4EC151D5.3040900@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 Zang Roy-R61911 <r61911@freescale.com>,
 "'Alexandre.Bounine@idt.com'" <Alexandre.Bounine@idt.com>,
 Jiang Kai-B18973 <B18973@freescale.com>,
 "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
 "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>,
 Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yeah, send binding first should be better for reviewing entire set of patch=
es.
Thanks!

-----Original Message-----
From: Wood Scott-B07421=20
Sent: Tuesday, November 15, 2011 1:37 AM
To: Liu Gang-B34182
Cc: Li Yang-R58472; Jiang Kai-B18973; linux-kernel@vger.kernel.org; Zang Ro=
y-R61911; Alexandre.Bounine@idt.com; akpm@linux-foundation.org; linuxppc-de=
v@lists.ozlabs.org; Gala Kumar-B11780
Subject: Re: [PATCH 4/5, v3] powerpc/8xxx: Update device tree bus probe for=
 new RapidIO node binding

On 11/14/2011 11:35 AM, Scott Wood wrote:
> On 11/12/2011 06:02 AM, Liu Gang wrote:
>> From: Kai Jiang <Kai.Jiang@freescale.com>
>>
>> Update of_platform_bus_probe() RapidIO node to be compitable with new=20
>> RapidIO dts compatible property.
>>
>> Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>  arch/powerpc/platforms/85xx/corenet_ds.c   |    2 +-
>>  arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
>>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c=20
>> b/arch/powerpc/platforms/85xx/corenet_ds.c
>> index 802ad11..c48b661 100644
>> --- a/arch/powerpc/platforms/85xx/corenet_ds.c
>> +++ b/arch/powerpc/platforms/85xx/corenet_ds.c
>> @@ -112,7 +112,7 @@ static const struct of_device_id of_device_ids[] __d=
evinitconst =3D {
>>  		.compatible	=3D "simple-bus"
>>  	},
>>  	{
>> -		.compatible	=3D "fsl,rapidio-delta",
>> +		.compatible	=3D "fsl,srio",
>=20
> fsl,srio is too vague.  We need to identify the specific hardware (or=20
> at least a concrete programming interface document), not just the bus =20
> that the hardware implements.

Never mind, I see that the binding is more specific about what this string =
means.

Next time have the binding come first. :-)

-Scott
