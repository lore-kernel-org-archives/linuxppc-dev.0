Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7243F2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 15:34:09 +1000 (EST)
Received: by mail-ob0-f169.google.com with SMTP id up14so12237902obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:34:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374611079-28091-3-git-send-email-aaro.koskinen@iki.fi>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
 <1374611079-28091-3-git-send-email-aaro.koskinen@iki.fi>
Date: Wed, 24 Jul 2013 11:04:06 +0530
Message-ID: <CAKohponoKzQv+jqgHsqsAgEkaQeeZof6XtegKdPwa4mLE3b9UA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cpufreq: pmac64: enable cpufreq on iMac G5 (iSight)
 model
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Nick Piggin <npiggin@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24 July 2013 01:54, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Enable cpufreq on iMac G5 (iSight) model. Tested with the 2.1 GHz version.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
