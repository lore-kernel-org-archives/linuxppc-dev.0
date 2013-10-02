Return-Path: <B32579@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9C5422C03B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 22:33:03 +1000 (EST)
Message-ID: <524C1238.1060001@freescale.com>
Date: Wed, 2 Oct 2013 18:01:52 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2][v7] powerpc/mpc85xx:Add initial device tree support
 of T104x
References: <1380524042-13720-1-git-send-email-prabhakar@freescale.com>	
 <1380570471.24959.517.camel@snotra.buserror.net>	
 <524A40F4.9040406@freescale.com>
 <1380657408.10618.52.camel@snotra.buserror.net>
In-Reply-To: <1380657408.10618.52.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/02/2013 01:26 AM, Scott Wood wrote:
> On Tue, 2013-10-01 at 08:56 +0530, Prabhakar Kushwaha wrote:
>> On 10/01/2013 01:17 AM, Scott Wood wrote:
>>> On Mon, 2013-09-30 at 12:24 +0530, Prabhakar Kushwaha wrote:
>>>>       - Removed l2switch. It will be added later
>>> Why?
>> I am not aware of bindings required for l2switch as we are not working
>> on the driver.
>> Earlier I thought of putting a place holder. but as you suggested to put
>> bindings in documentation.
>> It will be good if it is put by actual driver owner.
> Is there a reason to believe the binding will be complicated?
>
> Does any such "driver owner" exist yet?

I don't know, as I am unaware of l2switch driver.

>
>>>> +sata@220000 {
>>>> +			fsl,iommu-parent = <&pamu0>;
>>>> +			fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
>>>> +};
>>>> +/include/ "qoriq-sata2-1.dtsi"
>>>> +sata@221000 {
>>>> +			fsl,iommu-parent = <&pamu0>;
>>>> +			fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
>>>> +};
>>> Whitespace
>> do we have any scripts which check for whitespace as checkpatch never
>> give any warning/error.
>> it is a very silly mistake which I am doing continuously :(
> checkpatch doesn't check dts files.
Manual check :(

>>>> +/include/ "t1040si-post.dtsi"
>>> Should at least have a comment indicating that eventually this should
>>> hold the l2 switch node.
>> yes. Ideally it should be.
>> but if I put a comment then I believe this patch will not be completed.
>> it will think as a RFC.
>> as I believe putting of TODO is generally for RFC patches.
> As is, one would wonder why the separate file exists at all.
>
> The TODO is there whether you have a comment acknowledging it or
> not. :-)
>
>
I agree. I will add a comments.

Regards,
Prabhakar
