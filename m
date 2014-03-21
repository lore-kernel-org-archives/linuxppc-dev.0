Return-Path: <viresh.linux@gmail.com>
Received: from mail-ve0-x236.google.com (mail-ve0-x236.google.com
 [IPv6:2607:f8b0:400c:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 210A72C00A8
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 18:46:08 +1100 (EST)
Received: by mail-ve0-f182.google.com with SMTP id jw12so2141405veb.41
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 00:46:03 -0700 (PDT)
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 13:16:03 +0530
Message-ID: <CAOh2x=mYnRWEqs=qBi4C4OWog+ds85=e+uDTJGpojozEr-XKhQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] powernv: Enable Dynamic Frequency
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> This is the v3 of the consolidated patchset consisting
> patches for enabling cpufreq on IBM POWERNV platforms
> along with some enhancements.

This is the first time I saw them. Looks like you never Cc'd linux-pm list.
Also, would be better to keep Maintainers in --to field so that they can
review them as soon as possible. Otherwise they might stay on lists for
a long time..
