Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C3BDB2C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:58:37 +1000 (EST)
Message-ID: <1377151097.25016.287.camel@pasglop>
Subject: Re: [RFC PATCH V3 3/5] powerpc/cpuidle: Generic powerpc backend
 cpuidle driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 15:58:17 +1000
In-Reply-To: <5215A69F.4090904@linux.vnet.ibm.com>
References: <20130819042736.8609.17890.stgit@deepthi.in.ibm.com>
 <20130819042818.8609.77060.stgit@deepthi.in.ibm.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259010226D5@039-SN2MPN1-021.039d.mgd.msft.net>
 <5211F0E0.7080507@linux.vnet.ibm.com>
 <1376936241.31636.352.camel@snotra.buserror.net>
 <521447E7.5000302@linux.vnet.ibm.com>
 <1377115703.5029.14.camel@snotra.buserror.net>
 <5215A69F.4090904@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>,
 "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-22 at 11:20 +0530, Deepthi Dharwar wrote:
> But if having cpuidle backend-driver separately for other powerpc arcs
> makes sense such that each one have their own state information etc
> then it makes sense to name the files as cpuidle-power.c,
> cpuilde-ppc32.c and so on.

If by "power" you mean IBM POWER machines/CPUs, then make it
cpuidle-ibm-power or cpuidle-book3s64 maybe to clarify what families it
affects.

Cheers
Ben.
