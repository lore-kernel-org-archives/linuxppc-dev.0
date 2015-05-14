Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id CB3861A001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:51:03 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
Date: Thu, 14 May 2015 02:16:11 +0200
Message-ID: <1842725.60y5FMGEPh@vostro.rjw.lan>
In-Reply-To: <7h7fsc2idw.fsf@deeprootsystems.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <2919083.VPTOth98op@vostro.rjw.lan> <7h7fsc2idw.fsf@deeprootsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rlippert@google.com, Ulf Hansson <ulf.hansson@linaro.org>,
 rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org,
 linus.walleij@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, May 13, 2015 03:59:55 PM Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> [...]
> 
> > Second, quite honestly, I don't see a connection to genpd here.
> 
> The connection with genpd is because the *reason* the timer was
> shutdown/stopped is because it shares power with the CPU, which is why
> the timer stops when the CPU hits ceratin low power states.  IOW, it's
> in the same power domain as the CPU.

Well, what if you don't have genpd on that system?  Is the problem at hand not
relevant then magically?

Rafael
