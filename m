From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>
Cc: <akpm@osdl.org>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] MachineCheck exception broken for MPC 8xx CPU's
Date: Tue, 25 May 2004 17:16:43 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEEENDCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20040525144030.GX6763@smtp.west.cox.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Tue, May 25, 2004 at 08:17:19PM +1000, Paul Mackerras wrote:
>
> > Joakim Tjernlund writes:
> >
> > > The Machine Check exception handler is broken on MPC 8xx CPU's
> > > This patch should fix it.
> > > Tom Rini asked me to send it to you.
> >
> > Hmmm, this doesn't look like it will apply.  The patch looks to be
> > against linuxppc-2.5, not Andrew's/Linus' tree.
> >
> > In fact I don't think there is a great deal of point in applying this
> > patch until we update arch/ppc/kernel/head_8xx.S with all the other
> > changes we have in the linuxppc-2.5 tree.
>
> Aside from one less thing to pull out and push ahead?  I was hoping to
> avoid exactly that if possible. :)

Well, since the stock kernel is broken for 8xx I don't think that is going to work.
You need to push the 8xx changes in linuxppc-2.5 to akpm and then it will
be possible/meaningful to generate patches against the stock kernel.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
