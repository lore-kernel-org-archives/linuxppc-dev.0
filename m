Date: Fri, 11 Jun 2004 16:16:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Another problem with pk pull of linuxppc-2.4
Message-ID: <20040611161638.A2772@home.com>
References: <29365-19760@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29365-19760@sneakemail.com>; from 612dlag102@sneakemail.com on Fri, Jun 11, 2004 at 08:52:44AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 11, 2004 at 08:52:44AM -0700, Stephen Williams wrote:
>
> The ibm405gpr.h header file is missing the definition of OPB_BASE_START.
> I copied the definitions from the linuxppc_2_4_devel tree and it worked
> just fine, so I believe this is a correct patch.

Yep.

> According to bk, this file hasn't been changed in linuxppc-2.4 in over
> a year (2003-03-12) so *how* pray tell have people been compiling this
> thing for PPC405GPr? Who's the right party for getting this patch
> installed?

Applied. I'm the right person for 4xx things. Paul posted the various
people that handle patches recently on two occasions.

FWIW, this means that (1) nobody has tried compiling linuxppc-2.4 for
405gpr in a long time (2) it probably broke during the 2.4 OCP rewrite
but its not any developer's primary devel platform (3) Everybody is
concentrating on 2.6...I know that it works fine there. :)

Thanks for the patch.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
