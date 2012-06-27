Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 32D9AB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 21:49:03 +1000 (EST)
Message-ID: <1340797732.3732.46.camel@pasglop>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Date: Wed, 27 Jun 2012 21:48:52 +1000
In-Reply-To: <20120627102138.GB10476@localhost.localdomain>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <1340748634.3732.27.camel@pasglop>
 <20120627102138.GB10476@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-27 at 18:21 +0800, Zhao Chenhui wrote:
> > What's that CONFIG option for ?
> > 
> > Cheers,
> > Ben.
> 
> This option is to guard the timebase sync routines. It is selected
> when KEXEC or HOTPLUG_CPU is enabled on Freescale Book-E platforms.

Any reason not to just make it unconditional ? That sort of config
option tend to just confuse things and make bug reports harder to sort
out.... Also you decrease your test coverage.

Cheers,
Ben.
