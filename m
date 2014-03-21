Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f47.google.com (mail-oa0-f47.google.com
 [209.85.219.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E7CCD2C0086
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 00:12:53 +1100 (EST)
Received: by mail-oa0-f47.google.com with SMTP id i11so2475168oag.6
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 06:12:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140321130450.GD2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
 <20140321130450.GD2493@in.ibm.com>
Date: Fri, 21 Mar 2014 18:42:50 +0530
Message-ID: <CAKohpomHHToqOND=ZtMeqBd11X3VA=PeZ2K6Tyj31y2V4G9-uA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Linux PM list <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 March 2014 18:34, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Consider the case when pmspr = 0x00feffffffffffff;
>
> We are interested in extracting the value 'fe'. And ensure that when
> we store this value into an int, we get the sign extension right.
>
> So the following doesn't work:
>
>    pstate_id = (pmspr_val >> 48) & 0xFFFFFFFF;

What about pstate_id = (pmspr_val >> 48) & 0xFF; ??
