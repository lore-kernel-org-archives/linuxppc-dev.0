To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Dale Farnsworth <dale@farnsworth.org>
Subject: Re: MPC5xxx code issues 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Nov 2003 13:29:44 MST."
             <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net>
Date: Mon, 17 Nov 2003 21:43:15 +0100
Message-Id: <20031117204320.E0605C5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Tom,

in message <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> Must clean: These files need some sort of rewrite to look less like
> a drop of commerical code into the kernel and more like working the
> commercial code into the kernel:
> arch/ppc/5xxx_io/bestcomm/capi/Makefile
> arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos1/Makefile
> arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos2/Makefile
> arch/ppc/5xxx_io/bestcomm/include/dummy files (should these be needed?)

I recommend NOT to touch anything in  the  bestocmm  directory.  This
stuff  is  supplied  directly by Motorola, and it is more than likely
that new versions of this code will have to be dropped in soon.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Anything free is worth what you pay for it.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
