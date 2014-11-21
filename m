Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A29F1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 20:17:36 +1100 (AEDT)
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C7C97140187
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 20:17:35 +1100 (AEDT)
Received: by mail-oi0-f52.google.com with SMTP id h136so3318912oig.25
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 01:17:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <dedc11e3150d44ee89bb1e96b5447687@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
 <1416554882-16566-2-git-send-email-Yuantian.Tang@freescale.com>
 <CAKohpo=xLOxXrCJNO0LmrVxMDNsFy2Kxg6bNzHm=vQCJnBvSaw@mail.gmail.com>
 <dedc11e3150d44ee89bb1e96b5447687@DM2PR03MB574.namprd03.prod.outlook.com>
Date: Fri, 21 Nov 2014 14:47:33 +0530
Message-ID: <CAKohpomtSBosPqU_DcB2Y=gxLXCG9d7MSy92LsMjeebQmVwDxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: qoriq: rename the driver
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 November 2014 14:46, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> When I use -C -M options, checkpatch reports error:
>
> [tangyt@titan linux-pm]$ ./scripts/checkpatch.pl 0002-cpufreq-qoriq-rename-the-driver.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #15:
>  drivers/cpufreq/{ppc-corenet-cpufreq.c => qoriq-cpufreq.c} | 0
>
> ERROR: Does not appear to be a unified-diff format patch
>
> total: 1 errors, 1 warnings, 0 lines checked
>
> 0002-cpufreq-qoriq-rename-the-driver.patch has style problems, please review.
>
> I just rename it and do not change anyting. Isn't that allowed?

Ignore these warnings.
