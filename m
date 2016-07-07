Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3rldf45zp3zDqx9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 23:25:16 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, steve.muckle@linaro.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 2/2] cpufreq: Reuse new freq-table helpers
Date: Thu, 07 Jul 2016 15:29:48 +0200
Message-ID: <3343635.EHbr2qf22Z@vostro.rjw.lan>
In-Reply-To: <29326603f17249f7636fc4ada43b96ad455fecbb.1467001203.git.viresh.kumar@linaro.org>
References: <cover.1467001203.git.viresh.kumar@linaro.org>
 <29326603f17249f7636fc4ada43b96ad455fecbb.1467001203.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, June 27, 2016 09:59:34 AM Viresh Kumar wrote:
> This patch migrates few users of cpufreq tables to the new helpers that
> work on sorted freq-tables.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
