Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 120822C0128
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2013 10:40:27 +1000 (EST)
Message-ID: <51F5BA06.4080109@freescale.com>
Date: Mon, 29 Jul 2013 08:40:38 +0800
From: Zhang Haijun <B42677@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/2 V2] mmc: esdhc: get voltage from dts file
References: <1374712691-12807-1-git-send-email-Haijun.Zhang@freescale.com>
 <20130726191858.GB14216@lizard>
In-Reply-To: <20130726191858.GB14216@lizard>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linux-mmc@vger.kernel.org, AFLEMING@freescale.com, scottwood@freescale.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/27/2013 03:18 AM, Anton Vorontsov wrote:
> On Thu, Jul 25, 2013 at 08:38:11AM +0800, Haijun Zhang wrote:
>> Add voltage-range support in esdhc of T4, So we can choose
>> to read voltages from dts file as one optional.
>> If we can get a valid voltage-range from device node, we use
>> this voltage as the final voltage support. Else we still read
>> from capacity or from other provider.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
> Development process nitpick...
>
> The code originated from me, but I did not sign off this patch...
>
> Per Documentation/SubmittingPatches:
>
>    The Signed-off-by: tag indicates that the signer was involved in the
>    development of the patch, or that he/she was in the patch's delivery path.
>
> The order of the sign-off lines also has a meaning. Putting my sign off
> below yours means that I was not only involved in the development of the
> patch but also somehow approved the patch (but I did not :).
>
> [..]
>> +void sdhci_get_voltage(struct platform_device *pdev)
> You still duplicate the code... Per my previous email, this should
> probably go into mmc/core (with the function renamed to something more
> generic, of course.)
>
> Thanks,
>
> Anton
>
Thanks Anton.

I'll correct this and resend the patch.

-- 
Thanks & Regards

Haijun
