From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16045.43640.243207.193539@nanango.paulus.ozlabs.org>
Date: Tue, 29 Apr 2003 08:26:00 +1000 (EST)
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BK Id header removals causes patch to fail!
In-Reply-To: <IGEFJKJNHJDCBKALBJLLCEFDFMAA.joakim.tjernlund@lumentis.se>
References: <IGEFJKJNHJDCBKALBJLLMEFBFMAA.joakim.tjernlund@lumentis.se>
	<IGEFJKJNHJDCBKALBJLLCEFDFMAA.joakim.tjernlund@lumentis.se>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund writes:

> > A typical BK Id in a file looks likes this:
> >
> > And in the patch it looks like this:
> > /*
> >  * BK Id: SCCS/s.setup.c 1.111 10/29/02 10:49:05 trini
> >  */
> >
> > And the patch:
> > @@ -1,7 +1,4 @@
> >  /*
> > - * BK Id: %F% %I% %G% %U% %#%
> > - */
> > -/*
> >
> >  Jocke
>
> I can't find BK command/option which will fix this problem.
> What was the rationale behind this pointless cleanup? I can understand if
> you do this in 2.5 but why do it in 2.4?
>
> Is there a way to fix this using BK?

I assume you mean that it looks like SCCS/s.setup.c ... in the file
and %F% ... in the patch.

Try doing a 'bk -r get -k' in the tree that you are patching before
you patch.  That should get all the files in the %F% ... form.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
