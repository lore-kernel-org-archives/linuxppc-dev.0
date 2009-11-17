Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 024C4B70CF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 13:10:49 +1100 (EST)
Subject: Re: [PATCH 4/13] pmac-zilog, mac68k: replace mac68k SCC code with
	platform device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
In-Reply-To: <alpine.OSX.2.00.0911031442360.483@silk.local>
References: <alpine.OSX.2.00.0911031442360.483@silk.local>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Nov 2009 13:10:36 +1100
Message-ID: <1258423836.2140.560.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-m68k@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-04 at 00:40 +1100, Finn Thain wrote:
> Remove the old 68k Mac serial port code and a lot of related cruft. Add 
> platform driver support to the pmac-zilog driver, putting the powermac- 
> specific bits inside #ifdef CONFIG_PPC_PMAC. Add new platform devices to 
> mac68k.
> 
> Tested on a beige G3 PowerMac and a variety of 68k Macs.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Can you split that patch into one that adds the pmac_zilog bit, and a
separate one that then removes the old m68k stuff ?

Cheers,
Ben.
