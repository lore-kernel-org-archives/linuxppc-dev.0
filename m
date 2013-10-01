Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 3306B2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 14:48:53 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2 RESEND 0/3] cpufreq/ondemand support for Xserve G5 &
 iMac G5 iSight
Date: Tue, 01 Oct 2013 07:00:18 +0200
Message-ID: <1431916.leHx1ThHeV@vostro.rjw.lan>
In-Reply-To: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
References: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, September 30, 2013 11:44:30 PM Aaro Koskinen wrote:
> Hi,
> 
> This is a resend of the v2 patchset:
> 
> 	http://marc.info/?t=137797013200001&r=1&w=2
> 
> No changes except rebasing. Any chance to get these into v3.13?

Well, Ben's ACKs are missing as far as I'm concerned ...

> Aaro Koskinen (3):
>   cpufreq: pmac64: speed up frequency switch
>   cpufreq: pmac64: provide cpufreq transition latency for older G5
>     models
>   cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model
> 
>  drivers/cpufreq/pmac64-cpufreq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
