Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E9CFA2C016C
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 14:43:56 +1100 (EST)
Received: by mail-ob0-f175.google.com with SMTP id uy5so3420459obc.20
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:43:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140321145452.GA8755@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
 <20140321104317.GA2493@in.ibm.com>
 <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
 <20140321145452.GA8755@in.ibm.com>
Date: Sat, 22 Mar 2014 09:13:53 +0530
Message-ID: <CAKohponk-attkX9O+Q2y_YcKYsNRHc6TQz5MZeQe_VPXzKR2wA@mail.gmail.com>
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

On 21 March 2014 20:24, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Ok, I guess the right thing to do at this point is call
>
>    cpufreq_table_validate_and_show(policy, powernv_freqs);
>
> Will fix the code to take care of this.

Yes.
