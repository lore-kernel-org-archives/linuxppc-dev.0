Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB8432C00BA
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 22:47:21 +1100 (EST)
Received: by mail-ob0-f181.google.com with SMTP id wp4so2279105obc.26
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 04:47:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <532C263F.4090504@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
 <532C263F.4090504@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 17:17:19 +0530
Message-ID: <CAKohpomrU5RDFkXi1iNCSiPxYjd-Cb6EjYiVGoc_U_hJ+MEEaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21 March 2014 17:15, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> I think you have Srivatsa there who has seen lots of cpufreq code and
>> could have helped you a lot :)
>>
>
> :-)

I was waiting for your reply here :)

> I have followed the locking and synchronization aspects of cpufreq
> closely, but unfortunately, I haven't been able to keep up with some of
> the other details that well :-( Besides, its hard to keep up with the
> rate of your changes, you are way too fast! ;-)

Haha.. I am a very slow guy, really :)
