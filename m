Date: Tue, 9 Apr 2002 16:15:37 -0400
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Message-ID: <20020409161537.A11697@nevyn.them.org>
References: <0204092005.AA24074@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204092005.AA24074@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 09, 2002 at 01:05:42PM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Taking debian as an example here.  You certainly wouldn't stick a zImage
> > for every board into 1 package.
>
> Exactly, which is why I never liked that idea.
>
> > So you only 'win' if you have a common, _bootable_ image on all of these
> > boards.
>
> Yes.
>
> > And while it is possible that there could be a common
> > firmware, I'm not holding my breath. :)
>
> When I go to Debian with this, I'll be asking for a ppcstar subarch to join to
> the ranks of apus, chrp, powermac, and prep. All HEC PPC boards will be
> PPCStar-compliant. If another manufacturer wants Debian support, they'll have
> to address Debian themselves and decide for themselves if they want to
> standardize their boot mechanism to make their request more acceptable.

Debian only supplies CONFIG_ALL_PPC images right now.  The
CHRP/pmac/PREP breakdown was only for 2.2.

If GENERIC_PPC32 is adequate, I'll do that instead - when it's ready.

--
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
