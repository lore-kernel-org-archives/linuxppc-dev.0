Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnJ0L1hjczDqpG
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jul 2016 16:16:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki"  <rafael.j.wysocki@intel.com>,
 Daniel Lezcano  <daniel.lezcano@linaro.org>
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
In-Reply-To: <1467958853-35841-11-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467958853-35841-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467958853-35841-11-git-send-email-shreyas@linux.vnet.ibm.com>
Date: Sun, 10 Jul 2016 16:16:49 +1000
Message-ID: <877fcuj9v2.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com> writes:

> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>  a) new instruction named stop is added.
>  b) new per thread SPR named PSSCR is added which controls the behavior
> 	of stop instruction.
>
> Supported idle states and value to be written to PSSCR register to enter
> any idle state is exposed via ibm,cpu-idle-state-names and
> ibm,cpu-idle-state-psscr respectively. To enter an idle state,
> platform provided power_stop() needs to be invoked with the appropriate
> PSSCR value.
>
> This patch adds support for this new mechanism in cpuidle powernv driver.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Cc: linux-pm@vger.kernel.org

Rafael/Daniel do you guys want to ack or nack this?

I'll take silence as "not bothered" and merge the whole series via the
powerpc tree.

cheers
