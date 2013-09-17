Return-Path: <B42677@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43FA52C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 10:56:34 +1000 (EST)
Received: from mail28-tx2 (localhost [127.0.0.1])	by mail28-tx2-R.bigfish.com
 (Postfix) with ESMTP id 7431B4A013E	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 17 Sep 2013 00:56:30 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.248])	by
 mail28-tx2.bigfish.com (Postfix) with ESMTP id 73ADE460041	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 00:56:20 +0000 (UTC)
Message-ID: <5237A8B7.9020104@freescale.com>
Date: Tue, 17 Sep 2013 08:56:23 +0800
From: Zhang Haijun <b42677@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Powerpc/dts: Correct sdhci quirk for bsc9131
References: <1378118222-17338-1-git-send-email-Haijun.Zhang@freescale.com>
 <5236BD62.8050604@freescale.com>
 <1379360577.2536.142.camel@snotra.buserror.net>
In-Reply-To: <1379360577.2536.142.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I see, thanks. ^_^

=E4=BA=8E 2013/9/17 3:42, Scott Wood =E5=86=99=E9=81=93:
> On Mon, 2013-09-16 at 16:12 +0800, Zhang Haijun wrote:
>> On 09/02/2013 06:37 PM, Haijun Zhang wrote:
>>> We use property "sdhci,auto-cmd12" instead of "fsl,sdhci-auto-cmd12"
>>> to distinguish if the sdhc host has quirk SDHCI_QUIRK_MULTIBLOCK_READ=
_ACMD12.
>>>
>>> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
>>> ---
>>>    arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi b/arch/pow=
erpc/boot/dts/fsl/bsc9131si-post.dtsi
>>> index 5180d9d..0c0efa9 100644
>>> --- a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
>>> +++ b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
>>> @@ -130,7 +130,7 @@ usb@22000 {
>>>
>>>    /include/ "pq3-esdhc-0.dtsi"
>>>    	sdhc@2e000 {
>>> -		fsl,sdhci-auto-cmd12;
>>> +		sdhci,auto-cmd12;
>>>    		interrupts =3D <41 0x2 0 0>;
>>>    	};
>>>
>>>
>>
>> Hi, scott
>>
>> Could you help review this patch?
> I process patches in periodic batches.  There's no need for a reminder
> when it's only been two weeks, as long as it's still marked "new" or
> "under review" in patchwork (and you should include a patchwork link in
> any such reminder e-mail).  Especially for a trivial patch such as this=
,
> no comment often means I looked at it and saw no problems and will take
> it in the next batch.
>
> Though if you want a comment, don't capitalize "powerpc" in the
> subject. :-)
>
> -Scott
>
>

--=20
Thanks & Regards
Haijun.
