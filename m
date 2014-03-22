Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 63CD62C00A8
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 14:43:24 +1100 (EST)
Received: by mail-ob0-f175.google.com with SMTP id uy5so3436347obc.6
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:43:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140321144818.GA30371@dirshya.in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
 <20140321104317.GA2493@in.ibm.com>
 <20140321144818.GA30371@dirshya.in.ibm.com>
Date: Sat, 22 Mar 2014 09:13:21 +0530
Message-ID: <CAKohpomMTJ8dHg7i48fEACCvr7evXRvtbNrv5TJCYLL1v6iY5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 March 2014 20:18, Vaidyanathan Srinivasan
<svaidy@linux.vnet.ibm.com> wrote:
> Yeah, I had the driver written using driver_data to store pstates.
> Gautham found the bug that we are missing one PState when we match the
> ID with CPUFREQ_BOOST_FREQ!

I see..

> We did not know that you have taken care of those issues.  Ideally
> I did expect that driver_data should not be touched by the framework.
> Thanks for fixing that and allowing the back-end driver to use
> driver_data.

No, I haven't fixed anything yet. And this piece of code still exists.
I will see if I can get this fixed, by that time you can continue the
way your code is there in this version.
