Message-ID: <38035584.C82792C2@chpc.utah.edu>
Date: Tue, 12 Oct 1999 09:36:36 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Daniel Jacobowitz <drow@false.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
References: <199909101833.UAA17210@piglet.cpu.lu> <3802D9FE.1C166944@chpc.utah.edu> <19991012105001.A698@drow.res.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz wrote:

> Could you check whether that kernel has the patch I posted to this list
> last month applied?

As you suspect, 2.2.13pre15 does not have your patch. AC's 2.2.13pre15 doesn't
have any changes at all to it's controlfb.c code. It's still the same as even in
the kernel distro of 2.2.6 (which is the earliest kernel I still have a copy of
source for on hand). Given a number of different behavioral characteristics
people have been describing of kernel's from vger I'd say there's been other
changes as well that still haven't made it into the Linus or AC distributed
kernel sources either unfortunately. I'm not in the privvy as far as I know
however to push these changes into the main stream kernel sources but if you or
someone else on this lilst is I say: "please, please get the in!". ;-) I guess in
the meantime I'm going to have to try sucking down the sources from vger but
given that I've been badly afflicted by the PPP/TCP death march that I and others
have been discussing I'm unsure I'll succeed at getting the whole thing from
vger.

> The patch was in Message-ID: <19990912141014.A17732@them.org>.
> On Tue, Oct 12, 1999 at 12:49:34AM -0600, Lou Langholtz wrote:
> > Michel Lanners wrote:
> > > On  10 Sep, this message from Lou Langholtz echoed through cyberspace:
> > > > After getting an extra 2MB VRAM for my PowerMac7500 and seeing that only
> > > > 2MB were still being recognized (despite having just added the 2MB to
> > > > total to 4MB VRAM), I dug into the controlfb.c code from 2.2.11 and
> > > > 2.2.12 and made the following changes to get all 4MB VRAM recognized:
> > > . . .
> > Even with 2.2.13pre15, the stock controlfb.c still doesn't detect the
> > 4MB VRAM in my 7500 (I just tried it). . . .


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
