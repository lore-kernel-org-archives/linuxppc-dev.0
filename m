Return-Path: <geert@linux-m68k.org>
Date: Tue, 9 Aug 2005 15:11:09 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0508091510400.28068@numbat.sonytel.be>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
	<bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joel Schopp <jschopp@austin.ibm.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>, linuxppc64-dev@ozlabs.org
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 9 Aug 2005, Segher Boessenkool wrote:
> > > I don't see the merge as changing the actual code that gets executed
> > > on any given platform very much, except in one respect: we are going
> > > to standardize on a flattened device tree as the way that information
> > > about the platform gets passed from the boot loader to the kernel.
                         ^^^^^^^^^^^^^^^^^^^^^***********^^^^^^^^******^

> > > Comments? Flames? :)
> > 
> > There are several userspace applications that parse the non-flat device tree
> > in /proc/device-tree on pSeries.  While I like the idea of the flattened
> > device tree I think we need to consider how many apps we are going to break
> > with it.
> 
> _Please_ don't throw the real device tree away; I'm happy with
> the flattened device tree if and only if it is a _minimum_
> requirement, and having a _real_ device tree (or even real
> Open Firmware support) is still an option.
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
