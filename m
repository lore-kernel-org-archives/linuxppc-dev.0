Message-ID: <005601c2f24f$f8e23e30$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	<strauman@SLAC.Stanford.EDU>
References: <IGEFJKJNHJDCBKALBJLLEEGBFLAA.joakim.tjernlund@lumentis.se> <20030324201543.GB14264@ip68-0-152-218.tc.ph.cox.net> <003501c2f248$06ddc700$020120b0@jockeXP> <20030324210712.GC14264@ip68-0-152-218.tc.ph.cox.net>
Subject: Re: dcbz works on 862 everywhere!
Date: Mon, 24 Mar 2003 22:54:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Mon, Mar 24, 2003 at 09:57:43PM +0100, Joakim Tjernlund wrote:
> > > Can you post a patch which does everything (remove the TLB change bit,
> > > etc)?  Thanks.
> >
> > Sure, but I don't want to restore the old TLB change bit. I removed it as a test only to see if
> > my system could take it. The kernel will do a lot DTLB errors if it is restored.
> >
> > I will removed the Guarded flag though since I don't see why it's there. Speak up
> > now if you want to have it left.
>
> Well, if I understand what you think you've got working correctly, what
> you've got replaces the current workaround for a similar (related?)
> issue.

I think it makes the "copy DAR to MD_EPN" part in the DTLB error handler needless.
Anyway it works with and without that part.

  Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
