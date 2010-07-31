Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 624E0B70A9
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 16:30:33 +1000 (EST)
Received: by iwn36 with SMTP id 36so2181560iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 23:30:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100730064521.GA20351@oksana.dev.rtsoft.ru>
References: <AANLkTimBP98EwRuvU_dj-RM2kaXZ-FSZ=GQxdod9VQeU@mail.gmail.com>
	<20100730064521.GA20351@oksana.dev.rtsoft.ru>
Date: Fri, 30 Jul 2010 23:30:31 -0700
Message-ID: <AANLkTim5haWhjzDKz9e=EBzZhVZAamZr937CrP6rU_jR@mail.gmail.com>
Subject: Re: Which microcode patch for MPC870?
From: Shawn Jin <shawnxjin@gmail.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Which microcode patch should be selected for MPC870? In the old 2.4
>> kernel, the CONFIG_UCODE_PATCH was selected. What's the corresponding
>> config: CONFIG_USB_SOF_UCODE_PATCH or CONFIG_I2C_SPI_UCODE_PATCH or
>> CONFIG_I2C_SPI_SMC1_UCODE_PATCH? Since my board doesn't have USB, I
>> believe USB microcode is irrelevant here. So it comes down the other
>> two choices. Of course do I really need the patch? My board has I2C
>> and SMC1, but no SPI.
>>
>> I chose CONFIG_I2C_SPI_UCODE_PATCH as an experiment but got the
>> following compilation error:
>
> These errors were fixed by
>
> http://patchwork.ozlabs.org/patch/58262/
> and
> http://patchwork.ozlabs.org/patch/58263/

Thanks a lot for the info, Anton.

Then the question is which patch should be selected. I don't enable
any patch and the SMC UART works properly. Next I'm going to enable
I2C but I don't know whether a microcode patch is required or not.

Thanks,
-Shawn.
