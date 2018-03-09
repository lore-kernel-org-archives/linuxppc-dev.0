Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyNDL2XCtzF1tq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 21:00:32 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id h11so1091963pfn.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 02:00:32 -0800 (PST)
Date: Fri, 9 Mar 2018 15:30:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, bcm-kernel-feedback-list@broadcom.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Markus Mayer <mmayer@broadcom.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 00/27] cpufreq: Stop validating cpufreq table in drivers
Message-ID: <20180309100026.GQ6842@vireshk-i7>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1519620578.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26-02-18, 10:38, Viresh Kumar wrote:
> Hi,
> 
> A patchset [1] sent last week already updated the cpufreq core to start
> validating cpufreq table if the policy contains a valid
> "policy->freq_table" pointer.
> 
> This series updates all such drivers to stop validating the cpufreq
> table directly and let only the core handle it.
> 
> It depends on the previous series [1] and two cleanup patches [2][3] and
> is rebased over 4.16-rc3.
> 
> It is already tested by the 0-day testing infrastructure and no issues
> were reported.

We will assume no objections or concerns if you (cc'd here and on the individual
commits) don't respond and the series will then get merged into linux-next next
week.

Thanks.

--
viresh
