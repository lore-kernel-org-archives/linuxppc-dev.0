Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47D5A2C0086
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 00:34:30 +1100 (EST)
Received: by mail-oa0-f51.google.com with SMTP id i4so2493872oah.24
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 06:34:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140321132326.GE2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
 <20140321104317.GA2493@in.ibm.com>
 <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
 <20140321132326.GE2493@in.ibm.com>
Date: Fri, 21 Mar 2014 19:04:27 +0530
Message-ID: <CAKohpom9MFsWjionC0S7zyZ479s8tsK150hhZ0frdJ-QKN_ZNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PM list <linux-pm@vger.kernel.org>,
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

On 21 March 2014 18:53, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Ok, I had based my code on linus's git tree. I checked the 'pm-cpufreq'

Always check his bleeding-edge or linux-next branch.

> branch of Rafael's 'linux-pm' tree and freq_table.c contains the
> following code snippet in show_available_frequencies:
>
>         if (show_boost ^ (table[i].driver_data == CPUFREQ_BOOST_FREQ))
>                         continue;
>
> I suspect we're talking about different code bases. So could you
> please tell me which one should I be looking at ?

Okay, there is some problem here. I will check how can I simplify this..
And yes, you were correct.

>> Because cpufreq_frequency_table_get_attr() and
>> cpufreq_frequency_table_put_attr() don't exist anymore :)
>
> Well, it does in the codebases that I was looking at. May be I've been
> looking at the wrong place.

Check the one I mentioned.
