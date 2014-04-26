Return-Path: <stratosk@semaphore.gr>
Received: from sema.semaphore.gr (unknown [78.46.194.137])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1732140141
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Apr 2014 21:35:44 +1000 (EST)
Message-ID: <535B9A09.9060902@semaphore.gr>
Date: Sat, 26 Apr 2014 14:35:37 +0300
From: Stratos Karafotis <stratosk@semaphore.gr>
MIME-Version: 1.0
To: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v5 2/8] cpufreq: Use cpufreq_for_each_* macros for
 frequency table iteration
References: <535AC26A.1000006@semaphore.gr>
 <CA+V-a8sg9sBi5mf9KoFWrCJjw6WN+tGrb=bgJwfV3VDZ2DGYig@mail.gmail.com>
In-Reply-To: <CA+V-a8sg9sBi5mf9KoFWrCJjw6WN+tGrb=bgJwfV3VDZ2DGYig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Prabhakar,

On 26/04/2014 12:57 μμ, Prabhakar Lad wrote:
> Hi Stratos,
> 
> Thanks for the patch,
> 
> On Sat, Apr 26, 2014 at 1:45 AM, Stratos Karafotis
> <stratosk@semaphore.gr> wrote:
>> The cpufreq core now supports the cpufreq_for_each_entry and
>> cpufreq_for_each_valid_entry macros helpers for iteration over the
>> cpufreq_frequency_table, so use them.
>>
>> It should have no functional changes.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> 
> For patches 1 & 2:  Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> and for patch 3: Acked-and-tested-by: Lad, Prabhakar
> <prabhakar.csengg@gmail.com>
> 
> Thanks,
> --Prabhakar lad
> 

Thank you very much!


Stratos Karafotis
