Date: Thu, 31 Jul 2003 15:48:43 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Richard Danter <richard.danter@windriver.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 750/107 CHRP question
Message-ID: <20030731154843.A8523@home.com>
References: <3F2949D3.8020106@windriver.com> <20030731140700.A7553@home.com> <3F298CED.8010701@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F298CED.8010701@windriver.com>; from richard.danter@windriver.com on Thu, Jul 31, 2003 at 10:41:01PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 31, 2003 at 10:41:01PM +0100, Richard Danter wrote:
>
> Matt Porter wrote:
> > [Oh my !#$!@.  I never thought I'd be replying to a Linux question
> >  from WRS. I need to check for reports of natural disasters and
> >  mass rioting. :)]
>
> LOL!!
>
> Yes, I work for WRS, but this is a little personal project just for the
> hell of it. I just happen to be using a WRS board and vICE to do the
> debugging.

Sure, we believe you. :)

> >>How do I map this correctly???
> >
> > In 2.4, you can use early_serial_setup() or io_block_map().  It is
> > highly recommended to use early_serial_setup().  There are many
> > examples of this (spruce, lopec, etc.)
>
> Thanks, I'll take a look at that.
>
> I'm sure this bit is easy, the tricky stuff will probably be when I
> start playing with PCI...

That'll be easy too.  Look at how the MPC10x-based ports are using
the mpc10x_common.c code.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
