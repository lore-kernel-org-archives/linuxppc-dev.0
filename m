Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4DB82BDA5
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Oct 2004 09:31:57 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041022173046.003bf2ea.colin@colino.net>
References: <20041022173046.003bf2ea.colin@colino.net>
Content-Type: text/plain
Message-Id: <1098487824.6028.91.camel@gaston>
Mime-Version: 1.0
Date: Sat, 23 Oct 2004 09:30:24 +1000
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: hda errors on iBook G4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2004-10-23 at 01:30, Colin Leroy wrote:
> Hi,
> 
> I noticed hda status errors in my iBook G4's dmesg quite a long time
> ago, but never looked any more... Today I just ran tests with hdparm and
> this looks like really reproduceable:
> 
> Results are different whether I try it only or more, see below.
> 
> Any hint about where I should look at, and what kind of bug may cause
> this error?

Just stop messing with the transfer speeds with hdparm ;) This is
bad, the ide-pmac driver will automatically pick the optimal speed
for your drive.

Ben.
