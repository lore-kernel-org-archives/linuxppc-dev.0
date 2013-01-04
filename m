Return-Path: <jjo.braun@gmail.com>
Received: from mail-ia0-f180.google.com (mail-ia0-f180.google.com
 [209.85.210.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D8BF2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 22:30:16 +1100 (EST)
Received: by mail-ia0-f180.google.com with SMTP id t4so13463466iag.25
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2013 03:30:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130104114947.0f350bd4@crub>
References: <CADwvPCve5GaRZZXuLUq4Es2FLN8AxtbRP4TQP7gQVRXoMw3S0g@mail.gmail.com>
 <20130103151106.04e1ae94@crub>
 <CADwvPCuw7p+O6bXtAoR=6yK9UgBR4JV58f+4s42KMDsvQ-dB6w@mail.gmail.com>
 <20130104114947.0f350bd4@crub>
Date: Fri, 4 Jan 2013 12:30:13 +0100
Message-ID: <CADwvPCtmuEtg=T9-HiLaby6HDV-W8oa2ctJjXg8wGbyBF2-WQw@mail.gmail.com>
Subject: Re: tqm5200s i2c bus timeout
From: Johannes Braun <jjo.braun@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> The good thing is that I can see all the devices now. Also the driver
>> for the rtc clock is loading. But the time can`t be read through the
>> registered rtc0 device. This is the kernel log. But I think this is a
>> driver issue and I should have a look inside the driver.
>>
>> [    1.483761] rtc-pcf8563 1-0051: chip found, driver version 0.4.3
>> [    1.490382] rtc-pcf8563 1-0051: pcf8563_get_datetime: read error
>> [    1.497478] rtc-pcf8563 1-0051: rtc core: registered rtc-pcf8563 as rtc0
>
> The RTC slave address is correct. Is the pcf8563 RTC on I2C2 bus on
> your board?

My address was not correct. The rtc clock is on I2C1 bus. I moved the
rtc node to the I2C1 node. The rtc clock works now.

Thanks,
Johannes
