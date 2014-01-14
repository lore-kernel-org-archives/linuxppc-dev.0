Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B55962C0091
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 19:20:54 +1100 (EST)
Message-ID: <1389687638.6933.11.camel@pasglop>
Subject: Re: [PATCH] Move precessing of MCE queued event out from syscall
 exit path.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Tue, 14 Jan 2014 19:20:38 +1100
In-Reply-To: <alpine.LSU.2.11.1401132314380.3222@eggly.anvils>
References: <20140114042611.13145.6551.stgit@mars.in.ibm.com>
 <alpine.LSU.2.11.1401132314380.3222@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-13 at 23:47 -0800, Hugh Dickins wrote:
> 
> And I may be quite wrong to point a finger at ATA errors: perhaps
> they're always shown, and quickly cleared off screen in successful
> boots,
> but left visible when root cannot be mounted for some other reason.

dmesg would tell...

> I don't know, and won't have time to investigate further - bisecting
> intermittents is not much fun!  I'll just have to hope that it's
> sorted out before it reaches 3.14-rc, or else bite the bullet and
> investigate on that.)

Right :-) Oh well, I still use a G5 as a desktop so I might eventually
stumble upon them !

Cheers,
Ben.
