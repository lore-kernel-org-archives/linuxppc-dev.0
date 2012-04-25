Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 30E10B6FAA
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2012 18:38:57 +1000 (EST)
Message-ID: <1335343125.21961.33.camel@pasglop>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Wed, 25 Apr 2012 18:38:45 +1000
In-Reply-To: <m2397sz1er.fsf@igel.home>
References: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
 <m2397sz1er.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-25 at 10:00 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > The biggest change is that windfarm is ported to generally use
> > the new model, and I've written a new set of windfarm modules to
> > take over from the old therm_pm72 (which was mostly unfixable)
> > on the PowerMac G5 AGP and Xserve G5 machines.
> 
> I have the impression that the new driver keeps the fans running faster
> all the time.

There's a few things you can try. Both drivers put the various values &
speeds in sysfs, tho in different places. You can do a test such as
overnight idle or something like that and compare the averages.

Also, does the new driver properly react to load ?

The algorithm should be identical and the factors fed to it as well, but
there's always the possibility that I screwed up something.

Cheers,
Ben.
