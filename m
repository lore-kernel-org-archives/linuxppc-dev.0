Return-Path: <stripathi@apm.com>
Received: from mail-yh0-f46.google.com (exprod5og123.obsmtp.com [64.18.0.198])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3FD21A0D2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:23:27 +1100 (AEDT)
Received: by mail-yh0-f46.google.com with SMTP id c41so7789967yho.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 20:23:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <1422379260-10139-3-git-send-email-stripathi@apm.com>
 <4747424.udeKOcy6tC@wuerfel>
 <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
Date: Wed, 28 Jan 2015 09:53:25 +0530
Message-ID: <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
From: Suman Tripathi <stripathi@apm.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>,
 anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net,
 patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

I added the iommus in the IOMMU AHBC patch. Anything wrong in that ?
In the next version Also I will remove the IOMMU hacks from arasan
driver

On Wed, Jan 28, 2015 at 9:48 AM, Suman Tripathi <stripathi@apm.com> wrote:
> Hi Arnd,
>
> On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
>>
>> +               sdhc0: sdhc@1c000000 {
>> +                       device_type = "sdhc";
>> +                       compatible = "arasan,sdhci-8.9a";
>> +                       reg = <0x0 0x1c000000 0x0 0x100>;
>> +                       interrupts = <0x0 0x49 0x4>;
>> +                       clock-names = "clk_xin", "clk_ahb";
>> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
>> +               };
>> +
>
> Here you don't provide an 'iommus' property, which means that the
> device is unable to use the iommu.
> I added the iommus in the IOMMU AHBC patch. Anything wrong in that ? In the
> next version Also I will remove the IOMMU hacks from arasan driver
>
>
> On Wed, Jan 28, 2015 at 1:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
>> >
>> > +               sdhc0: sdhc@1c000000 {
>> > +                       device_type = "sdhc";
>> > +                       compatible = "arasan,sdhci-8.9a";
>> > +                       reg = <0x0 0x1c000000 0x0 0x100>;
>> > +                       interrupts = <0x0 0x49 0x4>;
>> > +                       clock-names = "clk_xin", "clk_ahb";
>> > +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
>> > +               };
>> > +
>>
>> Here you don't provide an 'iommus' property, which means that the
>> device is unable to use the iommu.
>>
>>         Arnd
>
>
>
>
> --
> Thanks,
> with regards,
> Suman Tripathi



-- 
Thanks,
with regards,
Suman Tripathi
