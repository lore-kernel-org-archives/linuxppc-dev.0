Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqg58zCzF0Wd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:07 +1100 (AEDT)
In-Reply-To: <1509443520-27106-1-git-send-email-anju@linux.vnet.ibm.com>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, anju@linux.vnet.ibm.com
Subject: Re: powerpc/perf: Change the data type for the variable 'ncpu' in IMC
 code
Message-Id: <3zPxqg2xyYz9sNr@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-31 at 09:52:00 UTC, Anju T Sudhakar wrote:
> Change the data type for the variable 'ncpu' in ppc_core_imc_cpu_offline(),
> since cpumask_any_but() returns an 'int' value.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Reported-by: David Binderman <dcb314@hotmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/074db39e00bb0d35cda7de9a4bae3a

cheers
