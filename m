Message-ID: <005401c2e0e4$27a1b6b0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <drow@false.org>
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
Date: Sun, 2 Mar 2003 18:50:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > I can't tell you what revs they were, but all of the MPC860's I could
> > > get my hands on here the last time I tried to use dcbz on them were
> > > faulty. You may just not be triggering the bug.
> >
> > hmm, what boards was this?
> > I am planning to a larger test here with all our custom mpc860 and mpc862 boards. We have them in
> > 100, 80 and 50 MHZ variants.
> >
> > May be the bug is related to board design?  Is there an official errata from Motorla
> > regarding this bug? I can't find any.
> >
> > Anyhow I had a flaw in my testprogram, so you can throw this version of copy_page() away.
> > But enabling the use of dcbz in the current version still gives me 30%+ performance increase.
> >
> > See the embedded list for details.
> >
> >  Jocke

I found a link that may have relevance regarding  the dcbz problem , can anybody confirm this?
http://www.uwsg.iu.edu/hypermail/linux/kernel/0012.0/0529.html

    Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
