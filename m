Return-Path: <trini@kernel.crashing.org>
Date: Tue, 9 Aug 2005 10:47:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050809174717.GO3187@smtp.west.cox.net>
References: <20050809162133.GL3187@smtp.west.cox.net>
	<B154269E-A429-47B3-B088-68C9BECD9A1C@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B154269E-A429-47B3-B088-68C9BECD9A1C@freescale.com>
Cc: linuxppc64-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 12:41:54PM -0500, Kumar Gala wrote:
> 
> On Aug 9, 2005, at 11:21 AM, Tom Rini wrote:
[snip]
> >That's not 100% true because as Segher said, prom_init.c is part of  
> >the
> >kernel (tree, image), but is what does the translation.
> 
> I'm not sure I follow.  I understand that prom_init.c is part of the  
> kernel in ppc64.  I'm saying that such things should NOT be part of  
> the arch/powerpc kernel going forward.  They should be handled via  
> bootwrappers.

That's a "cleanup" we can argue about later, but I expect some
resistance :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
