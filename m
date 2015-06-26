Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 7098C1A0248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 23:57:48 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, shreyas@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
Date: Fri, 26 Jun 2015 16:23:57 +0200
Message-ID: <2128915.HHL0NLglLy@vostro.rjw.lan>
In-Reply-To: <558B7715.1060802@linux.vnet.ibm.com>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
 <CAJZ5v0hiKVN7Nvc4w3BP9uWmvdUkX6T+DUGh6OSZWPTrpwcyjA@mail.gmail.com>
 <558B7715.1060802@linux.vnet.ibm.com>
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

On Thursday, June 25, 2015 09:05:49 AM Preeti U Murthy wrote:
> On 06/25/2015 05:36 AM, Rafael J. Wysocki wrote:
> > On Thu, Jun 25, 2015 at 12:06 AM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> >> On Wed, 2015-06-24 at 15:50 +0200, Rafael J. Wysocki wrote:
> >>> 4.2 material I suppose?
> >>
> >> And stable. Without this, if you configure without TICK_ONESHOT, the
> >> machine will hang.
> > 
> > OK, which -stable?  All of them or any specific series?
> 
> This needs to go into stable/linux-3.19.y,
> stable/linux-4.0.y, stable/linux-4.1.y.

So essentially 3.19+.  OK, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
