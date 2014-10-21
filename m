Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32F6D1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 20:03:35 +1100 (AEDT)
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A163114007B
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2014 20:03:34 +1100 (AEDT)
Received: by mail-ob0-f181.google.com with SMTP id wm4so607762obc.26
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2014 02:03:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6aaa50ef5f234fe2896f1c66eb646dfb@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1413515616-15874-1-git-send-email-B29983@freescale.com>
 <CAKohpokotKSvQ13uU4MnCer+qzBUUbGVTd19y7xswCAEKk3nGQ@mail.gmail.com>
 <6aaa50ef5f234fe2896f1c66eb646dfb@DM2PR03MB574.namprd03.prod.outlook.com>
Date: Tue, 21 Oct 2014 14:33:31 +0530
Message-ID: <CAKohpokSuKOwZ3-OWFtU0z7E1fsMg4tyPiUoFUfw26pD9Py=MA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qoriq: Make the driver usable on all QorIQ
 platforms
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 October 2014 14:29, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> If I do so, menuconfig will display like this(on PPC):
>         PowerPC CPU frequency scaling drivers  ----
>     QorIQ CPU Frequency scaling  --->
>                 <*> CPU frequency scaling driver for Freescale QorIQ SoCs
> On ARM, there should be a similar problem.
> Isn't weird?

Similar is true for cpufreq-cpu0 driver as well.. Maybe we can create a
Kconfig.drivers configuration and include it from all architecture specific
ones ?

@ Rafael ?
