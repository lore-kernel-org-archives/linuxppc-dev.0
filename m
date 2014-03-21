Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 63DD72C0084
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 22:45:22 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 17:15:20 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 16811125804D
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 17:17:39 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LBjNHE4653548
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 17:15:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LBjGOi019705
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 17:15:17 +0530
Message-ID: <532C263F.4090504@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 17:15:03 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
In-Reply-To: <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
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

On 03/21/2014 02:11 PM, Viresh Kumar wrote:
> On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
>> From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> 
> Hi Vaidy,
> 
>> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>> index 4b029c0..4ba1632 100644
>> --- a/drivers/cpufreq/Kconfig
>> +++ b/drivers/cpufreq/Kconfig
>> @@ -48,6 +48,7 @@ config CPU_FREQ_STAT_DETAILS
>>  choice
[...]
>> +static struct cpufreq_driver powernv_cpufreq_driver = {
>> +       .verify         = powernv_cpufreq_verify,
>> +       .target         = powernv_cpufreq_target,
> 
> I think you have Srivatsa there who has seen lots of cpufreq code and
> could have helped you a lot :)
>

:-)

I have followed the locking and synchronization aspects of cpufreq
closely, but unfortunately, I haven't been able to keep up with some of
the other details that well :-( Besides, its hard to keep up with the
rate of your changes, you are way too fast! ;-)

Regards,
Srivatsa S. Bhat
