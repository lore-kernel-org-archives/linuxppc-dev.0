Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BB2F12C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 08:50:17 +1000 (EST)
Message-ID: <1348699794.2443.14.camel@pasglop>
Subject: Re: enabling suspend-to-ram for a headless powerpc g4 mac mini
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Dowland <jmtd@debian.org>
Date: Thu, 27 Sep 2012 08:49:54 +1000
In-Reply-To: <20120926092755.GA7022@debian>
References: <20120926092755.GA7022@debian>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-26 at 10:27 +0100, Jon Dowland wrote:
> Can anyone give me some hints/pointers on how to configure or hack the
> kernel so that video is simply ignored?

Look at arch/powerpc/platforms/powermac/feature.c, fine the machine
table and add the flag to your entry: PMAC_MB_CAN_SLEEP

Makes sure you have no video driver loaded at all, nor AGP either.

Finally, it might not work ... hard to tell, there may be other things
needed.

Cheers,
Ben.
