Return-Path: <vincent.yang.fujitsu@gmail.com>
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com
 [IPv6:2607:f8b0:4002:c07::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AD3B1A0364
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 20:29:54 +1000 (EST)
Received: by mail-yk0-f174.google.com with SMTP id 19so2519382ykq.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 03:29:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5136245.WRbqGRMMHn@wuerfel>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1403256928-11359-6-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <5136245.WRbqGRMMHn@wuerfel>
Date: Fri, 20 Jun 2014 18:29:51 +0800
Message-ID: <CAOEd-H3Q+Men=MKoLrBK_faAXw3b6M5eJ+FxSSPq3idyAK=eGw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] mmc: sdhci: host: add new f_sdh30
From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Andy Green <andy.green@linaro.org>, patches@linaro.org, anton@enomsg.org,
 linux-mmc@vger.kernel.org, chris@printf.net,
 Vincent Yang <Vincent.Yang@tw.fujitsu.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,
Thanks a lot for your review.
I will update it in next version.


Best regards,
Vincent Yang

2014-06-20 18:00 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 20 June 2014 17:35:26 Vincent Yang wrote:
>> +Required properties:
>> +- compatible: "fujitsu,f_sdh30"
>> +
>> +Optional properties:
>> +- gpios: Specify gpios for controlling signal level
>> +- clocks: Specify clocks used by SDHCI controller
>> +- clock-names: Specify the clock-names to be used
>
> If you want to use "clock-names", you have to specify the exact names
> of the clock input signals used by your device, and the order in which
> they are listed.
>
> For both the clocks and the gpios, you have to specify how many signals
> there are, and ideally describe what they are used for. In case of a
> gpio controlling the signal level, it may be better to model this
> as a gpio-regulator device, depending on how exactly it is used.
>
> When posting a DT binding document, please always add
> devicetree@vger.kernel.org to Cc.
>
>         Arnd
