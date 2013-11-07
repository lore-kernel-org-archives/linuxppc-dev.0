Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 531A62C016E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 16:01:29 +1100 (EST)
Message-ID: <1383800462.4776.165.camel@pasglop>
Subject: Re: [PATCH V7 5/7] POWER/cpuidle: Generic POWER CPUIDLE driver
 supporting PSERIES.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Thu, 07 Nov 2013 16:01:02 +1100
In-Reply-To: <527B13C8.9030602@linux.vnet.ibm.com>
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
 <20131029110148.31547.8944.stgit@deepthi.in.ibm.com>
 <527AAF1D.5080605@linaro.org> <527B13C8.9030602@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 preeti@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 scottwood@freescale.com, linux-pm@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-07 at 09:45 +0530, Deepthi Dharwar wrote:
> 'powerpc' would be very generic arch and would comprise of all platforms
> including embedded 32/64 bit to server 64 bit (similar to that of ARM).
> This driver does not intend to support complete powerpc arch, but just
> PSERIES and POWERNV platforms termed as 'POWER' processors. So to avoid
> confusion btw 'power mgmt' and 'POWER' archs, I have prefixed both the
> driver and file names with 'IBM'namely ibm-power-driver, cpuidle-ibm-power.

Why not book3s ? powerpc-book3s ?

That's what we use in other places to differenciate between the families

Ben.
