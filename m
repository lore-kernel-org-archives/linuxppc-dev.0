Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f49.google.com (mail-oa0-f49.google.com
 [209.85.219.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0239D2C007E
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 23:34:11 +1100 (EST)
Received: by mail-oa0-f49.google.com with SMTP id h16so2391192oag.8
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 05:34:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
Date: Fri, 21 Mar 2014 18:04:08 +0530
Message-ID: <CAKohpo=E1UEcLhbZHtmBJcD3S3trm8ypT7++quF_t6XHDXAvHA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
From: Viresh Kumar <viresh.kumar@linaro.org>
To: David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 March 2014 17:31, David Laight <David.Laight@aculab.com> wrote:
>> *(int *)ret_freq = freq;
>
> Because it is very likely to be wrong.
> In general casts of pointers to integer types are dangerous.

Where are we converting pointers to integers? We are doing a
cast from 'void * ' to 'int *' and then using indirection operator
to set its value.
