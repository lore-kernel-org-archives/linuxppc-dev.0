Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: linuxppc_2_4_devel, rc1 and rc2 problem.
Date: Wed, 20 Nov 2002 16:46:05 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLOECMFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20021120152302.GI779@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> On Wed, Nov 20, 2002 at 12:55:01PM +0100, Joakim Tjernlund wrote:
> >
>
> > I upgraded my linuxppc_2_4_devel from pre8(1.1130) to rc1(1.1157) and noticed that
> > may syslog had problems to start:
> >
> [snip]
>
> > I then tried rc2(BK curr) and got the same problem. I am running a custom mpc860 board.
> >
> > Anyone else noticed this?
>
> I haven't tried yet.  Have you tried 'porting' your custom board to
> vanilla 2.4.x, which would make it easier to see which, if any of these
> upsteram revisions introduced a problem?  The only 8xx-specific changes
> in that time have been your i2c changes and a serial fixup.

hmm, my i2c stuff got into rc2 (and uart too?). I see this on rc2 AND rc1, but NOT in pre8.
No, I have not tried to port it to vanilla 2.4.x. It requires some work to do that.

 Jocke
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
