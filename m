Date: Mon, 2 Jul 2001 05:51:35 -0700
From: Matt Porter <mporter@mvista.com>
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mmu_decl.h- missing semi (was: Current state of the 2_4_devel tree)
Message-ID: <20010702055135.A17251@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.3.95.1010702060805.4368D-100000@november.bhjjh.erols.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.95.1010702060805.4368D-100000@november.bhjjh.erols.com>; from ghurwitz@dyndns.com on Mon, Jul 02, 2001 at 06:10:17AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 02, 2001 at 06:10:17AM -0400, Justin (Gus) Hurwitz wrote:
>
> I found the cause of the compile error I was having- there is a missing
> semi-colon after the setbat() declaration in arch/pp/mm/mmu_decl.h.
> Someone with write access might want to fix that (unless the kernel isn't
> supposed to compile :)

Done. Thanks.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
