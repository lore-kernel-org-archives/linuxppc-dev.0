Message-ID: <3D48569D.30201@embeddededge.com>
Date: Wed, 31 Jul 2002 17:29:01 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/PATCH] idle loop changes
References: <20020731193200.GD17472@opus.bloom.county> <3D4847D5.9030404@embeddededge.com> <20020731143357.C5793@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> So, some new machdep calls that you can populate on a per board basis?
> Are you just talking about them being used upon entering/exiting idle?

I was just thinking the power_save() function could be unique to a
board.  It has to be something combined with the power save mode
chosen on the chip, so machdep calls may not be appropriate.  We are
using names like ppc6xx_pm_idle, ppc4xx, ppc8xx, when it could be
my_custom_board_pm_idle......Just don't assume one type of chip will
use the same function on different boards.  When the idle/power save
function is chosen, it should probably be done during board setup,
not processor set up.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
