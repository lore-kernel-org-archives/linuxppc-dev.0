Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrsfg03Z4zF1bc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 21:45:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency
 table twice
In-Reply-To: <20180227034527.GQ26947@vireshk-i7>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
 <3120e4db4ae3bc014d198a206f46be1305ec65e8.1519620578.git.viresh.kumar@linaro.org>
 <871sh89dbr.fsf@concordia.ellerman.id.au> <20180227034527.GQ26947@vireshk-i7>
Date: Wed, 28 Feb 2018 21:45:45 +1100
Message-ID: <871sh54ckm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 26-02-18, 22:53, Michael Ellerman wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> > Subject: Re: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency table twice
>>                                            ^
>>                                       powernv
>> 
>> > The cpufreq core is already validating the CPU frequency table after
>> > calling the ->init() callback of the cpufreq drivers and the drivers
>> > don't need to do the same anymore. Though they need to set the
>> > policy->freq_table field directly from the ->init() callback now.
>> >
>> > Stop validating the frequency table from powerenv driver.
>
>                                              powernv :)
>
> Will fix both of them.

Thanks :)

cheers
