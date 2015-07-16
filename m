Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61DD11A08AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 19:54:58 +1000 (AEST)
In-Reply-To: <1436353561-19466-2-git-send-email-vipin@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>,
 joel@jms.id.au, vaibhav@linux.vnet.ibm.com
Subject: Re: [v9] powerpc/powernv: Add poweroff (EPOW,
 DPO) events support for PowerNV platform
Message-Id: <20150716095458.0A1B5140778@ozlabs.org>
Date: Thu, 16 Jul 2015 19:54:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-07 at 11:06:01 UTC, Vipin K Parashar wrote:
> This patch adds support for OPAL EPOW (Environmental and Power Warnings)
> and DPO (Delayed Power Off) events for the PowerNV platform. These events
> are generated on FSP (Flexible Service Processor) based systems. EPOW
> events are generated due to various critical system conditions that
> require system shutdown. A few examples of these conditions are high
> ambient temperature or system running on UPS power with low UPS battery.
> DPO event is generated in response to admin initiated system shutdown
> request. Upon receipt of EPOW and DPO events the host kernel invokes
> orderly_poweroff() for performing graceful system shutdown.
> 
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> Acked-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3b476aadbc1409fef6be

cheers
