Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB33EB8FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Sep 2023 03:39:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RgSm06KS9z3cGC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Sep 2023 13:39:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tinylab.org (client-ip=43.154.54.12; helo=bg4.exmail.qq.com; envelope-from=tanyuan@tinylab.org; receiver=lists.ozlabs.org)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RfNXZ6RK9z2xpw
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2023 19:25:22 +1000 (AEST)
X-QQ-mid: bizesmtpipv602t1693819483twsc
Received: from [IPV6:2001:da8:c000:3005:b045:d ( [255.215.175.9])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Sep 2023 17:24:40 +0800 (CST)
X-QQ-SSF: 00200000000000907000000A0000000
X-QQ-FEAT: 7Lv6dviieSQfCZLBi/a43AThgeMmumc/FRF+5kcPPikz9PbH07YcxZjiLC6zq
	SHbLoRbO5a1oMvOnfOf+VtMJdWuaPUX39IAqpMHfLDmkAldg7RJh0YKWCHqK1k5vKKlpDgB
	Y/zvjHgn3hs/o1zkUjUgncAYcHUeiFYZcofsGPZNROAbqNGM52+dm82oBN7oBUSNkeQs3qh
	1EuNJ0S4TjWVdLCu9DQftvlLVHlK7/yeQ1tV0f9giopq9Ylj1hg+xMmTWeBAagWnOL7JsRp
	e0Q0Cq2bJl3RueMwwZ7pgD1oA2WvR2NfNyBvNJVGSguXe/nkU0XMss2mDi0qHV6ViOUfzHN
	YYWKbvf5OmR6cJKPwmqzdbuCnoZIqX5V09jPNnHT+Qx+cAewVI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1055148611417415568
Message-ID: <55C9BDEDAB4E0B76+838dbd4f-425d-4f2e-94ee-f2bc3092ae13@tinylab.org>
Date: Mon, 4 Sep 2023 17:24:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] kconfig: add dependencies of POWER_RESET for mips
 malta
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 mpe@ellerman.id.au, christophe.leroy@csgroup.eu, tglx@linutronix.de,
 mingo@redhat.com, tsbogend@alpha.franken.de, hdegoede@redhat.com
References: <cover.1693535514.git.tanyuan@tinylab.org>
 <1c17f017d6c837ef887d08bd2f85102df3fbc17c.1693535514.git.tanyuan@tinylab.org>
 <915a9e2d-36ea-4a74-7b1b-9688f215b6f1@linaro.org>
From: Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <915a9e2d-36ea-4a74-7b1b-9688f215b6f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Mailman-Approved-At: Wed, 06 Sep 2023 13:38:46 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org, linux@weissschuh.net, falcon@tinylab.org, linuxppc-dev@lists.ozlabs.org, w@1wt.eu
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On 9/4/2023 3:40 PM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 1/9/23 04:42, Yuan Tan wrote:
>> MIPS Malta's power off depends on PCI, PCI_QUIRKS, and
>> POWER_RESET_PIIX4_POWEROFF to work. Enable them when POWER_RESET is set
>> for convenience.
>>
>> Suggested-by: Zhangjin Wu <falcon@tinylab.org>
>> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
>> ---
>>   arch/mips/Kconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index bc8421859006..13bacbd05125 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -547,6 +547,9 @@ config MIPS_MALTA
>>       select MIPS_L1_CACHE_SHIFT_6
>>       select MIPS_MSC
>>       select PCI_GT64XXX_PCI0
>> +    select PCI if POWER_RESET
>> +    select PCI_QUIRKS if POWER_RESET
>> +    select POWER_RESET_PIIX4_POWEROFF if POWER_RESET
>>       select SMP_UP if SMP
>>       select SWAP_IO_SPACE
>>       select SYS_HAS_CPU_MIPS32_R1
>
> Shouldn't we also update the _defconfig files?
>
Sorry, in my last email, I forgot to reply to all. So I am now resending 
this email.

In malta_defconfig, PCI and POWER_RESET_PIIX4_POWEROFF have already been 
set and PCI_QUIRKS is also selected by FSL_PCI [=n].

So shutdown and reboot with malta_defconfig is working and there is no 
need to update the malta_defconfig 🙂

