Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39DC12C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 01:21:00 +1100 (EST)
Date: Thu, 6 Feb 2014 15:20:30 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
In-Reply-To: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <alpine.DEB.2.02.1402061520040.21991@ionos.tec.linutronix.de>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An Thu, 6 Feb 2014, Nicolas Pitre wrote:

> The core idle loop now takes care of it.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
