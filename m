Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4CCCAB6FB6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 08:10:21 +1000 (EST)
Message-ID: <1340748603.3732.26.camel@pasglop>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 27 Jun 2012 08:10:03 +1000
In-Reply-To: <4FEA2D93.3030002@freescale.com>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <AB6D43A9-FC54-40D2-A9B0-8B2E785124F9@kernel.crashing.org>
 <4FEA2D93.3030002@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-06-26 at 16:45 -0500, Scott Wood wrote:

> Some parts are due to corenet versus non-corenet, such as the actual
> register you write to to disable/enable the timebase.
> 
> There's also a two-core assumption in the synchronization code which
> I've complained about multiple times -- although on closer inspection it
> looks like this is done under cpu_add_remove_lock, and we can assume
> that there's only one core at a time in take_timebase(), regardless of
> how many cores are in the system.

Right, it should work fine with any number of cores or am I missing
something ? (btw, since when complaining about something helps ? :-)

Cheers,
Ben.
