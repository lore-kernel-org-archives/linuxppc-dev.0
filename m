Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 59E8E2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 09:40:20 +1100 (EST)
Message-ID: <1393368002.6314.10.camel@pasglop>
Subject: Re: [PATCH] powerpc: warn users of smt-snooze-delay that the API
 isn't there anymore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 26 Feb 2014 09:40:02 +1100
In-Reply-To: <530C4D57.1030905@linux.vnet.ibm.com>
References: <1393028074-26797-1-git-send-email-cody@linux.vnet.ibm.com>
 <530C4D57.1030905@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Wang Dongsheng <dongsheng.wang@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-25 at 13:29 +0530, Deepthi Dharwar wrote:
> We currently do not use smt-snooze-delay in the kernel.
> The sysfs entries needs to  be retained until we do a clean up
> ppc64_cpu
> util that uses these entries to determine SMT,
> clean up patch for this has already been posted out by Prerna.
> Once, we have the ppc64_cpu changes in, we can look to clean up these
> parts from the kernel.

We generally shouldn't change user visible interfaces.

People still have old versions of ppc64_cpu, we must not break them

Cheers,
Ben.
