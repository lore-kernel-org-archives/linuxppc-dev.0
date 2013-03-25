Return-Path: <swarren@wwwdotorg.org>
Message-ID: <51507FEA.8040306@wwwdotorg.org>
Date: Mon, 25 Mar 2013 10:48:42 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Notify all policy->cpus in
 cpufreq_notify_transition()
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
 <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
In-Reply-To: <CAKohpo=JuyVmSRFs1wpqvvmouRpL+d8ms-o4UC74OJqAgFv7Vw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 sparclinux@vger.kernel.org, linaro-kernel@lists.linaro.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, arvind.chauhan@arm.com,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 Jesper Nilsson <jesper.nilsson@axis.com>, robin.randhawa@arm.com,
 cpufreq@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 cbe-oss-dev@lists.ozlabs.org, Fenghua Yu <fenghua.yu@intel.com>,
 Steve.Bannister@arm.com, Mike Frysinger <vapier@gentoo.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Liviu.Dudau@arm.com,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mikael Starvik <starvik@axis.com>,
 Kukjin Kim <kgene.kim@samsung.com>, Borislav Petkov <bp@alien8.de>,
 Ben Dooks <ben-linux@fluff.org>, Thomas Renninger <trenn@suse.de>,
 linux-arm-kernel@lists.infradead.org, rjw@sisk.pl,
 Tony Luck <tony.luck@intel.com>, Eric Miao <eric.y.miao@gmail.com>,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 Sascha Hauer <kernel@pengutronix.de>, charles.garcia-tobin@arm.com,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/24/2013 11:19 PM, Viresh Kumar wrote:
> On 24 March 2013 19:18, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> policy->cpus contains all online cpus that have single shared clock line. And
>> their frequencies are always updated together.
>>
>> Many SMP system's cpufreq drivers take care of this in individual drivers but
>> the best place for this code is in cpufreq core.
>>
>> This patch modifies cpufreq_notify_transition() to notify frequency change for
>> all cpus in policy->cpus and hence updates all users of this API.
> 
> Another fixup for tegra:

This series including this patch (although I had a devil of a time
applying this fixup since all the TABs got converted to spaces when it
was pasted into email)

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
