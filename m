Date: Thu, 7 Mar 2002 08:30:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: benh@kernel.crashing.org
Cc: Paul White <pwhite@bivio.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455
Message-ID: <20020307153005.GF19531@opus.bloom.county>
References: <Pine.LNX.4.21.0203062152510.30207-100000@stimpy.networkrobots.com> <20020306214849.11643@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020306214849.11643@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 06, 2002 at 10:48:49PM +0100, benh@kernel.crashing.org wrote:
>
> >Great!  It sounds like the firmware is doing everyhting.  It might be
> >nice to add an option to have linux configure the CPU registers or not,
> >as for us embedded guys thats easier than implimenting it all in the
> >firmware.  We can do it either way now that we know what the registers
> >should be, though.
>
> Well, then the correct place for the patch is probably in the wrapper
> or in a CONFIG_xxx option for your embedded box. At least for PReP/CHRP/Pmac,
> I want to rely on the firmware for various reasons (one beeing that Apple's
> firmware sets some bits in specific ways to avoid/workaround chip errata).

I'd think that outside of CONFIG_ALL_PPC (or wherever CHRP/Pmac end up
in 2.5.x) we don't care what the firmware did.

Unless of course we move all of the CPU-mucking into arch/ppc/boot, and
just pass along a CPU bi rec (or do what we do now, either way...)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
