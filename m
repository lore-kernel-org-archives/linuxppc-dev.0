Return-Path: <kumar.gala@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F2D5B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 01:57:35 +1100 (EST)
Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <45903308677306428B6EE7E6FF5A520408654D@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Mon, 17 Jan 2011 08:57:06 -0600
Message-ID: <54228DB3-E95B-4A4D-BB83-CABEACAD77C5@freescale.com>
References: <1295248259-14752-1-git-send-email-B33228@freescale.com>
	<4D342C6E.6000608@ru.mvista.com>
	<45903308677306428B6EE7E6FF5A520408654D@039-SN1MPN1-004.039d.mgd.msft.net>
To: Aggrwal Poonam-B10812 <B10812@freescale.com>
Cc: Xu Lei-B33228 <B33228@freescale.com>,
	Sergei Shtylyov <sshtylyov@mvista.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"jgarzik@pobox.com" <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 17, 2011, at 5:58 AM, Aggrwal Poonam-B10812 wrote:

> 
> 
>> -----Original Message-----
>> From: linuxppc-dev-bounces+poonam.aggrwal=freescale.com@lists.ozlabs.org
>> [mailto:linuxppc-dev-
>> bounces+poonam.aggrwal=freescale.com@lists.ozlabs.org] On Behalf Of
>> Sergei Shtylyov
>> Sent: Monday, January 17, 2011 5:18 PM
>> To: Xu Lei-B33228
>> Cc: jgarzik@pobox.com; Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org;
>> linux-ide@vger.kernel.org
>> Subject: Re: [PATCH] ATA: Add FSL sata v2 controller support
>> 
>> Hello.
>> 
>> On 17-01-2011 10:10, Xulei wrote:
>> 
>>> In FSL sata v2 block, the snoop bit of PRDT Word3 description
>>> information is at bit28 instead of bit22.
>> 
>>> This patch adds FSL sata v2 probe and resolve this difference.
>> 
>>> Signed-off-by: Xulei <B33228@freescale.com>
>> 
>>    AFAIK, full name is required.
>> 
>>> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
>> [...]
>> 
>>> diff --git a/arch/powerpc/boot/dts/p1022ds.dts
>>> b/arch/powerpc/boot/dts/p1022ds.dts
>>> index 2bbecbb..9ad41dd 100644
>>> --- a/arch/powerpc/boot/dts/p1022ds.dts
>>> +++ b/arch/powerpc/boot/dts/p1022ds.dts
>>> @@ -475,14 +475,14 @@
>>>  		};
>>> 
>>>  		sata@18000 {
>>> -			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
>>> +			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
> 
> Can we fix this compatibity at run time by u-boot?

We can, but its not reason not to update the .dts as well.

- k
