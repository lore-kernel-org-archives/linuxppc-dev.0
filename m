Date: Wed, 13 Oct 1999 08:30:25 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
In-Reply-To: <38035584.C82792C2@chpc.utah.edu>
Message-ID: <Pine.GSO.4.10.9910121824230.21248-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Oct 1999, Lou Langholtz wrote:
> Daniel Jacobowitz wrote:
> 
> > Could you check whether that kernel has the patch I posted to this list
> > last month applied?
> 
> As you suspect, 2.2.13pre15 does not have your patch. AC's 2.2.13pre15 doesn't
> have any changes at all to it's controlfb.c code. It's still the same as even in
> the kernel distro of 2.2.6 (which is the earliest kernel I still have a copy of
> source for on hand). Given a number of different behavioral characteristics
> people have been describing of kernel's from vger I'd say there's been other
> changes as well that still haven't made it into the Linus or AC distributed
> kernel sources either unfortunately. I'm not in the privvy as far as I know
> however to push these changes into the main stream kernel sources but if you or
> someone else on this lilst is I say: "please, please get the in!". ;-) I guess in
> the meantime I'm going to have to try sucking down the sources from vger but
> given that I've been badly afflicted by the PPP/TCP death march that I and others
> have been discussing I'm unsure I'll succeed at getting the whole thing from
> vger.

Linus accepted all video patches I sent him for 2.3.20.

Note that I assume no responsabilities for the video stuff in 2.2.x. I barely
have time to take care of 2.3.x.

That's the problem with anything besides ia32: we hardly have enough manpower
to work on 2.3.x, so who's taking care of 2.2.x?

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
