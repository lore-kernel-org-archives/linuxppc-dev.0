Message-ID: <001301c30dd8$f5f691e0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <paulus@samba.org>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLMEFBFMAA.joakim.tjernlund@lumentis.se><IGEFJKJNHJDCBKALBJLLCEFDFMAA.joakim.tjernlund@lumentis.se> <16045.43640.243207.193539@nanango.paulus.ozlabs.org>
Subject: Re: BK Id header removals causes patch to fail!
Date: Tue, 29 Apr 2003 00:53:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund writes:
>
> > > A typical BK Id in a file looks likes this:
> > >
> > > And in the patch it looks like this:
> > > /*
> > >  * BK Id: SCCS/s.setup.c 1.111 10/29/02 10:49:05 trini
> > >  */
> > >
> > > And the patch:
> > > @@ -1,7 +1,4 @@
> > >  /*
> > > - * BK Id: %F% %I% %G% %U% %#%
> > > - */
> > > -/*
> > >
> > >  Jocke
> >
> > I can't find BK command/option which will fix this problem.
> > What was the rationale behind this pointless cleanup? I can understand if
> > you do this in 2.5 but why do it in 2.4?
> >
> > Is there a way to fix this using BK?
>
> I assume you mean that it looks like SCCS/s.setup.c ... in the file
> and %F% ... in the patch.

Yes, sorry for the cut and paste error

>
> Try doing a 'bk -r get -k' in the tree that you are patching before
> you patch.  That should get all the files in the %F% ... form.

hmm, the tree I am patching is a CVS tree. I can't get these in %F% form with CVS.

           Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
