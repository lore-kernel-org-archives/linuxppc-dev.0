Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gMDc0BjzzF19d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 15:24:16 +1000 (AEST)
In-Reply-To: <1532423589-18730-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux@roeck-us.net
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-hwmon@vger.kernel.org, ego@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, stewart@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v8,
 1/2] powernv:opal-sensor-groups: Add support to enable sensor groups
Message-Id: <41gMDb4Ry7z9s4V@ozlabs.org>
Date: Wed,  1 Aug 2018 15:24:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-24 at 09:13:08 UTC, Shilpasri G Bhat wrote:
> Adds support to enable/disable a sensor group at runtime. This
> can be used to select the sensor groups that needs to be copied to
> main memory by OCC. Sensor groups like power, temperature, current,
> voltage, frequency, utilization can be enabled/disabled at runtime.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/04baaf28f40c68c35a413cd9d0db71

cheers
