Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B8EF2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 18:59:45 +1000 (EST)
Message-ID: <1368435563.19924.28.camel@pasglop>
Subject: Re: [RFC PATCH v3 0/5] powerpc: Support context tracking for Power
 pSeries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Mon, 13 May 2013 18:59:23 +1000
In-Reply-To: <1368432193.2618.30.camel@ThinkPad-T5421>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1368424306.19924.20.camel@pasglop>
 <1368432193.2618.30.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, paulus@samba.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-13 at 16:03 +0800, Li Zhong wrote:
> 
> To my understanding, it is used to enable RCU user extended quiescent
> state, so RCU on that cpu doesn't need scheduler ticks. And together
> with some other code(already in 3.10), we are able to remove the ticks
> in some cases (e.g. only 1 task running on the cpu, with some other
> limitations).

Ok, sounds interesting. Once you fix the little cosmetic issue, I don't
see any reason not to merge them as it's basically wiring up an existing
feature (in that regard the patches are pretty straightforward) and I
assume the overhead is only there when you enable it.

Cheers,
Ben.
