Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E1D9AB70B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 07:43:41 +1100 (EST)
Message-ID: <1322167404.32635.7.camel@pasglop>
Subject: RE: [PATCH 01/16] pmac_zilog: fix unexpected irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 25 Nov 2011 07:43:24 +1100
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AEE1@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AEE1@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org,
 Finn Thain <fthain@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-24 at 15:28 +0000, David Laight wrote:
> > On most 68k Macs the SCC IRQ is an autovector interrupt and cannot be 
> > masked. This can be a problem when pmac_zilog starts up.
> 
> Wouldn't this also happen if the interrupt were shared?
> Hopefully nothing vaguely modern uses the borked Zilog 8530 SCC
> (which I presume is the part in question - brings back
> too many nightmares....)

Yup. Afaik, the most recent you can find with that are PowerMacs which
used it for their internal modem (even my G5 has one wired to the
internal slot afaik), tho none of those had shared interrupts.

Cheers,
Ben.
