Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymM8w72bLzDqqV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 22:37:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv : Add support to enable sensor groups
In-Reply-To: <1511760988-10377-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1511760988-10377-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 22:37:36 +1100
Message-ID: <87bmjmzla7.fsf@concordia.ellerman.id.au>
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

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:

> Adds support to enable/disable a sensor group. This can be used to
> select the sensor groups that needs to be copied to main memory by
> OCC. Sensor groups like power, temperature, current, voltage,
> frequency, utilization can be enabled/disabled at runtime.
>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> The skiboot patch for the opal call is posted below:
> https://lists.ozlabs.org/pipermail/skiboot/2017-November/009713.html

Can you remind me why we're doing this with a completely bespoke sysfs
API, rather than using some generic sensors API?

And if we must do it that way, please add documentation for the sysfs
file(s) in Documentation/ABI/.

cheers
