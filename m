Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76B781007DA
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 09:01:51 +1100 (EST)
Message-ID: <1323295271.12793.1.camel@pasglop>
Subject: Re: [PATCH net-next v6 4/4] powerpc: tqm8548/tqm8xx: add and update
 CAN device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Date: Thu, 08 Dec 2011 09:01:11 +1100
In-Reply-To: <4EDF22DF.5020001@grandegger.com>
References: <1322732481-2255-1-git-send-email-wg@grandegger.com>
 <1322732481-2255-5-git-send-email-wg@grandegger.com>
 <1323243268.660.71.camel@pasglop> <4EDF22DF.5020001@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, socketcan-users@lists.berlios.de,
 linux-can@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-12-07 at 09:25 +0100, Wolfgang Grandegger wrote:

> > Also there have been at least 3 versions in a couple of days already
> > without comments nor indication of what was changed...
> 
> Unfortunately, no response from those sub-system guys.
> 
> > Can you clarify things a bit please ? It looks like they really should
> > go to linuxppc-dev (and you can probably drop a bunch of other lists) or
> > am I missing an important piece of the puzzle ? (Such as patch 1/4 and
> > 2/4 ...)
> 
> I have not sent the  whole series. The changes are documented in the
> cover-letter, which I have not sent for those patches. Well, I think
> it's better to sent the whole series to all parties instead?

Well at least for linuxppc-dev, don't bother now that I know what this
is about :-)

> > Let me know if I should just remove them from powerpc patchwork.
> 
> Dave has already applied all patches.
> 
> Sorry for the confusion. Any advice on how to handle multi subsystem
> series of patches properly is welcome.

No specific advice. Ideally, if patchwork could track cover letters it
would help but I don't see a non-nasty way to do it so ... :-)

Cheers,
Ben.
