Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTSB71S9bzDqcp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 21:30:22 +1000 (AEST)
Message-ID: <1465903788.30200.8.camel@kernel.crashing.org>
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 maddy@linux.vnet.ibm.com, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Jun 2016 21:29:48 +1000
In-Reply-To: <575FE0B0.4030309@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160613153446.GF10634@linaro.org>
 <575FE0B0.4030309@linux.vnet.ibm.com>
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

On Tue, 2016-06-14 at 16:17 +0530, Shreyas B Prabhu wrote:

> 
> I ignored adding this check because this is part of initcall and we are
> unlikely to run out of memory at this state. But I'll add the check in
> next version.

Why do you malloc the u64 array and not the string pointer array ?
Shouldn't you either have both on stack or both allocated ?

Cheers,
Ben.
