Message-ID: <3D485B2F.84829A96@mvista.com>
Date: Wed, 31 Jul 2002 17:48:31 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Matt Porter <porter@cox.net>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/PATCH] idle loop changes
References: <20020731193200.GD17472@opus.bloom.county> <3D4847D5.9030404@embeddededge.com> <20020731143357.C5793@home.com> <3D48569D.30201@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:

> Matt Porter wrote:
>
> > So, some new machdep calls that you can populate on a per board basis?
> > Are you just talking about them being used upon entering/exiting idle?
>
> I was just thinking the power_save() function could be unique to a
> board.  It has to be something combined with the power save mode
> chosen on the chip, so machdep calls may not be appropriate.  We are
> using names like ppc6xx_pm_idle, ppc4xx, ppc8xx, when it could be
> my_custom_board_pm_idle......Just don't assume one type of chip will
> use the same function on different boards.  When the idle/power save
> function is chosen, it should probably be done during board setup,
> not processor set up.

Why not use keep the ppc6xx_pm_idle, etc. as fallbacks (e.g., nothing
special about  your board so use generic 6xx one) and still use machdep
calls so its easy to override in case there is something special you need
to do for your board?

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
