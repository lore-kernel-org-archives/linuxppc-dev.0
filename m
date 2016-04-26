Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3qv3LB2JxBzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 10:06:57 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>, Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com,
 yuantian.tang@nxp.com
Subject: Re: [PATCH V3 1/2] cpufreq: qoriq: Remove __exit macro from .exit
 callback
Date: Tue, 26 Apr 2016 02:03:16 +0200
Message-ID: <1537942.znLWuyUMVk@vostro.rjw.lan>
In-Reply-To: <20160419091151.GA2905@vireshk-i7>
References: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
 <20160419091151.GA2905@vireshk-i7>
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

On Tuesday, April 19, 2016 02:41:51 PM Viresh Kumar wrote:
> On 19-04-16, 17:00, Jia Hongtao wrote:
> > .exit callback (qoriq_cpufreq_cpu_exit()) is also used during suspend.
> > So __exit macro should be removed or the function will be discarded.
> > 
> > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > ---
> >  drivers/cpufreq/qoriq-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!
