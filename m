Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqr2k0dzF0XS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:16 +1100 (AEDT)
In-Reply-To: <1513145394-6100-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 anju@linux.vnet.ibm.com
Subject: Re: [v2] platform/powernv: Add debugfs interface for imc-mode and
 imc-command
Message-Id: <3zPxqr0Ytgz9sRV@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-13 at 06:09:54 UTC, Anju T Sudhakar wrote:
> In memory Collection (IMC) counter pmu driver controls the ucode's execution
> state. At the system boot, IMC perf driver pause the ucode. Ucode state is
> changed to "running" only when any of the nest units are monitored or profiled
> using perf tool.                                      
...
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/684d984038aa2b8ec3ab4b9d314257

cheers
