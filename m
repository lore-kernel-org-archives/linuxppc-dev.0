Date: Fri, 29 Jun 2001 13:09:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Cleanups of arch/ppc/boot/Makefile
Message-ID: <20010629130926.B19846@opus.bloom.county>
References: <200106290629.IAA01327@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200106290629.IAA01327@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 29, 2001 at 08:29:51AM +0200, Michel Lanners wrote:
> On  28 Jun, this message from Tom Rini echoed through cyberspace:
> > Hey all.  After talking to paulus a bit, arch/ppc/boot/Makefile needs some
> > cleaning and fixing.
> [snip]
>
> +subdir-$(CONFIG_PRPMC750)	+= pp3 lib images common
> +tools-$(CONFIG_PRPMC750)	:= mkbugboot mkprep
> +subdir-$(CONFIG_MCPN765)	+= pp3 lib images common
> +tools-$(CONFIG_MCPN750)		:= mkbugboot mkprep
>                     ^^^
> Is this right? Shouldn't that be CONFIG_MCPN765?

Oops, mental goof.  Thanks.   Thats the other thing, I did this on an
ibook during class, so it's only been tested on CONFIG_ALL_PPC, with the
rest eyeballed for now :)  Thats another reason I didn't commit it.. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
