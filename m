Return-Path: <trini@kernel.crashing.org>
Date: Thu, 11 Aug 2005 12:59:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
Message-ID: <20050811195927.GX3187@smtp.west.cox.net>
References: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2005 at 11:45:10AM -0500, Becky Bruce wrote:

[snip]
> 	platforms/
> 		- platform-specific code laid out in the following 
> 		directories:
> 		pSeries/
> 		iSeries/
> 		pmac/  (both 32 and 64-bit)
> 		classic32/  (platforms containing 
> 		6xx/7xx/74xx/8240/8241/8245)
> 		classic64/  (Maple?)

I'm a bit ppc64-ignorant, but isn't 'pSeries' just a regular
OpenFirmware-containing ppc64 box (like Maple) ?  How about just 9xx/
for all of the ppc64's that have a 9xx in them (Maple), that aren't pmac
(which is a class of its own).

> 		83xx/ (may collapse into classic 32 at some point)
> 		86xx/ (may collapse into classic 32 at some point)
> 		pq2/ (may collapse into classic 32 at some point)

PQ2 is the marketing name for 82xx, lets just call it 82xx.

I don't like the idea of sticking subdirs in classic32/ either, but also
can't think of a better name for the catchall of 7xx and 74xx boards.

-- 
Tom Rini
http://gate.crashing.org/~trini/
