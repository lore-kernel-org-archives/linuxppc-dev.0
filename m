Message-ID: <3BBDE2E6.B65B3925@aps.anl.gov>
Date: Fri, 05 Oct 2001 11:42:14 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS?
References: <20011003130559.F31866@borg.org>
	 <20011003113245.B18196@cpe-24-221-152-185.az.sprintbbd.net>
	 <20011004092511.A3914@borg.org>
	 <20011004132953.B32269@cpe-24-221-152-185.az.sprintbbd.net>
	 <20011005111145.C8157@borg.org> <3BBDD64F.97B0057B@aps.anl.gov> <20011005122340.E8157@borg.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg wrote:
>
> And so do complete exports?  I didn't start out that way because I am
> running BK on an underpowered machine and complete exports are slow.
> Aso, where I work there are stupid security policies that force me to
> mail between that real internet connection that can do BK and the
> broken corporate network, and mailing whole kernels seems fraught with
> problems.

Can't you persuade your security people to allow you to make an incoming
ssh connection to your repository machine from your BK machine?  If so
then you shouldn't need to use mail, but if not then your idea of mailing
patches might be better if you can get it to work.  On the BK side you
probably don't have to do a complete export every day, just an update (or
whatever the BK equivalent is, I only know CVS...) and then you do a cvs
import of that tree.

> Your suggestion seesm to imply that complete exports are more reliable
> than deltas.  True?

If that's a question about BK I can't answer it as I've never used BK, so
don't make that implication.  I didn't really look at precisely what
you're doing with the BK stuff (because I don't understand the
terminology), I just thought about what you're trying to accomplish, which
is basically what cvs import does.

Sorry if that was a wild goose chase...

- Andrew
--
Perfection is reached, not when there is no longer anything to add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
