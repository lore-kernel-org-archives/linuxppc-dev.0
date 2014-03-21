Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3A8EF2C00CD
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:57:21 +1100 (EST)
Received: by mail-ob0-f172.google.com with SMTP id wm4so2213958obc.17
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 02:57:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140321095534.GF27293@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-5-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kLwDGFtHR5sBKhE-9L=3=npV4_i+B+BVm+yBocmmMvzQ@mail.gmail.com>
 <20140321095534.GF27293@in.ibm.com>
Date: Fri, 21 Mar 2014 15:27:19 +0530
Message-ID: <CAKohponhtLO1o6Dmr+=8-PM90tPMfJzPO_vr_bh5-xLphb-=MA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] powernv:cpufreq: Export nominal frequency via
 sysfs.
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
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

On 21 March 2014 15:25, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Probably the use of ATTR_RO(cpuinfo_nominal_freq) and renaming
> show_cpuinfo_nominal_freq to cpuinfo_nominal_freq_show() would be even
> better. What do you think ?

+1
