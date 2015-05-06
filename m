Return-Path: <michal.simek@xilinx.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0062.outbound.protection.outlook.com [157.56.111.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86D1C1A00F6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 18:00:40 +1000 (AEST)
Message-ID: <5549C68B.9090602@xilinx.com>
Date: Wed, 6 May 2015 09:45:15 +0200
From: Michal Simek <michal.simek@xilinx.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
 <CAOHikRC1dYd0BqhUCzdeZ8=PhSOj77sQR9kzrM8Gus3AJS1ejw@mail.gmail.com>
 <4635229.bceBxngCoe@wuerfel>
In-Reply-To: <4635229.bceBxngCoe@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "chris@printf.net" <chris@printf.net>, Michal Simek <michal.simek@xilinx.com>,
 "patches@apm.com" <patches@apm.com>, Rob Herring <robherring2@gmail.com>,
 Don Dutile <ddutile@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2015 09:31 AM, Arnd Bergmann wrote:
> On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
>>>> @@ -533,6 +567,16 @@
>>>>                         interrupts = <0x0 0x4f 0x4>;
>>>>                 };
>>>>
>>>> +               sdhc0: sdhc@1c000000 {
>>>> +                       device_type = "sdhc";
>>>
>>> device_type generally should not be used (there are a few exceptions).
>>
>> Okay !!
>>
> 
> While we're at it, please change sdhc@1c000000 to mmc@1c000000.
> Even though Linux does not care, we try to use the standard device
> names for consistency.

Do we have a list of these names somewhere?
Normally I do use ePARP - generic names recommendation but mmc or sdhci
are not listed there.
Both combination mmc@ or sdhci@ are used in the kernel.

On zynq and zynqmp we do use shdci@.

Thanks,
Michal
