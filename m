Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 237461A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:56:07 +1100 (AEDT)
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9F2661400E7
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 18:56:06 +1100 (AEDT)
Received: by mail-oi0-f45.google.com with SMTP id a141so3287714oig.18
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2014 23:56:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416554882-16566-2-git-send-email-Yuantian.Tang@freescale.com>
References: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
 <1416554882-16566-2-git-send-email-Yuantian.Tang@freescale.com>
Date: Fri, 21 Nov 2014 13:26:04 +0530
Message-ID: <CAKohpo=xLOxXrCJNO0LmrVxMDNsFy2Kxg6bNzHm=vQCJnBvSaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: qoriq: rename the driver
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: r64188@freescale.com, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
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

On 21 November 2014 12:58, Tang Yuantian <Yuantian.Tang@freescale.com> wrote:
> This driver works on all QorIQ platforms which include
> ARM-based cores and PPC-based cores.
> Rename it in order to represent better.
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 371 ----------------------------------
>  drivers/cpufreq/qoriq-cpufreq.c       | 371 ++++++++++++++++++++++++++++++++++
>  2 files changed, 371 insertions(+), 371 deletions(-)
>  delete mode 100644 drivers/cpufreq/ppc-corenet-cpufreq.c
>  create mode 100644 drivers/cpufreq/qoriq-cpufreq.c

This is not reviewable at all.. How do I verify that you haven't changed
something in the files as well ?

To make life easy always create patches with:

git format-patch -C -M

Above options handle renames pretty well.
