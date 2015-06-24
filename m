Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0356B1A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 10:26:36 +1000 (AEST)
Message-ID: <1435183570.3790.15.camel@kernel.crashing.org>
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, daniel.lezcano@linaro.org,
 mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
 linux-pm@vger.kernel.org, mpe@ellerman.id.au, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, shreyas@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Thu, 25 Jun 2015 08:06:10 +1000
In-Reply-To: <1700583.a34yOllUuC@vostro.rjw.lan>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
 <1700583.a34yOllUuC@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-24 at 15:50 +0200, Rafael J. Wysocki wrote:
> 4.2 material I suppose?

And stable. Without this, if you configure without TICK_ONESHOT, the
machine will hang.

Cheers,
Ben.
