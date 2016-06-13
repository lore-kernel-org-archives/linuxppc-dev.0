Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3rT4ls53lPzDqZ6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 06:54:48 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 09/11] cpuidle/powernv: Use CPUIDLE_STATE_MAX instead
 of MAX_POWERNV_IDLE_STATES
Date: Mon, 13 Jun 2016 22:58:52 +0200
Message-ID: <1824456.bQhIAi46Pe@vostro.rjw.lan>
In-Reply-To: <20160613150150.GE10634@linaro.org>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-10-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160613150150.GE10634@linaro.org>
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

On Monday, June 13, 2016 05:01:50 PM Daniel Lezcano wrote:
> On Wed, Jun 08, 2016 at 11:54:29AM -0500, Shreyas B. Prabhu wrote:
> > Use cpuidle's CPUIDLE_STATE_MAX macro instead of powernv specific
> > MAX_POWERNV_IDLE_STATES.
> > 
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Since this seems to depend on some other patches in the series, I'm expecting
it to go in along with the patches it depends on.

Thanks,
Rafael
