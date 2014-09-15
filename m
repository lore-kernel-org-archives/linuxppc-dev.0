Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B259E1A0027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 22:23:31 +1000 (EST)
Message-ID: <1410783796.31754.85.camel@pasglop>
Subject: Re: [PATCH] cpuidle/powernv: Enter fastsleep on checking if deep
 idle states are allowed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 08:23:16 -0400
In-Reply-To: <5416A8B0.8040603@linux.vnet.ibm.com>
References: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
 <1410764352.32643.2.camel@concordia> <5416A8B0.8040603@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-15 at 14:22 +0530, Preeti U Murthy wrote:
> > We were talking about getting rid of powersave_nap altogether, but I
> think we
> > decided we couldn't, I forget.
> 
> Isn't this a helpful knob to disable cpuidle at runtime? Currently we
> check the value of powersave_nap before entering both nap and
> fastsleep.

It's useful when diagnosing some problems that can be caused by idle
states.

Cheers,
Ben.
