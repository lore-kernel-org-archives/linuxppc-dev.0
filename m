Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pl0-x22a.google.com (mail-pl0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr4NF1s8QzF0p2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 14:45:32 +1100 (AEDT)
Received: by mail-pl0-x22a.google.com with SMTP id w21so10622477plp.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 19:45:32 -0800 (PST)
Date: Tue, 27 Feb 2018 09:15:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rafael Wysocki <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency
 table twice
Message-ID: <20180227034527.GQ26947@vireshk-i7>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
 <3120e4db4ae3bc014d198a206f46be1305ec65e8.1519620578.git.viresh.kumar@linaro.org>
 <871sh89dbr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871sh89dbr.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26-02-18, 22:53, Michael Ellerman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> > Subject: Re: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency table twice
>                                            ^
>                                       powernv
> 
> > The cpufreq core is already validating the CPU frequency table after
> > calling the ->init() callback of the cpufreq drivers and the drivers
> > don't need to do the same anymore. Though they need to set the
> > policy->freq_table field directly from the ->init() callback now.
> >
> > Stop validating the frequency table from powerenv driver.

                                             powernv :)

Will fix both of them.

-- 
viresh
