Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17148.7234.193140.997481@cargo.ozlabs.ibm.com>
Date: Fri, 12 Aug 2005 13:49:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050811195927.GX3187@smtp.west.cox.net>
References: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
	<20050811195927.GX3187@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org, Becky Bruce <becky.bruce@freescale.com>,
	linuxppc64-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini writes:

> I'm a bit ppc64-ignorant, but isn't 'pSeries' just a regular
> OpenFirmware-containing ppc64 box (like Maple) ?  How about just 9xx/

Ummm, no, not exactly.  The distinctive thing about pSeries is the
hypervisor interfaces.  And in fact most pSeries boxes aren't
970-based, rather POWER4/4+/5.  If you want to generalize, we could
call the directory "papr" (for Power Architecture Platform
Requirements, the name of the document that describes the pSeries
platforms) rather than pSeries, but I suspect that would just confuse
people. :)

Paul.
