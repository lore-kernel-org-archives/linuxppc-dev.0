Message-ID: <3D3D55BA.711A3052@mvista.com>
Date: Tue, 23 Jul 2002 08:10:18 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: dank@kegel.com
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	Jan Olderdissen <jolderdissen@ixiacom.com>,
	Dan Kegel <dkegel@ixiacom.com>
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
References: <3D3901F5.1FEEBB65@kegel.com> <3D397E52.2E5CEE74@mvista.com> <3D3D4E6A.9550399F@kegel.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dank@kegel.com wrote:
>
> Mark Hatle wrote:
> >
> > The atonicity patches had not been submitted back to glibc due to there being
> > now way for me to show it was needed, and also that it ONLY affects the 405 CPU,
> > which isn't the main target of glibc.
> >
> > We are currently working on revising our glibc patches to the current CVS
> > version, and if a new patch is required I'll make sure it gets posted here.  I
> > really don't know the best way to handle this in a community glibc/gcc realm.
> > I'd almost like to wait and see what the GCC maintainers response is.
> > Specifically how they are going to accept the patch.  Then we propose a similar
> > thing to the glibc folks, explain the problem and hope they accept the patch as
> > well.
>
> Mark,
> I've rediffed your glibc patch and made it conditional on defined(__PPC405__);
> result at http://www.kegel.com/xgcc3/glibc-2.2.5-ppc405erratum77.patch
> I haven't tested it yet, but something like that should make the maintainers happy.
> What do you think?

Sounds good..  (as I said before we're in the process of re doing our diff for
2.2.5 as well, so I'll compare them and make sure neither of us missed
anything.  We havn't added the __PPC405__ bit yet, but planned on doing so
soon.)

> Also, according to http://gcc.gnu.org/contribute.html, patches for bugs
> are more likely to be accepted if there is a bug report in gnats,
> so I opened a bug for stdlibc++
> http://gcc.gnu.org/cgi-bin/gnatsweb.pl?cmd=view%20audit-trail&database=gcc&pr=7383
> and one for glibc at
> http://bugs.gnu.org/cgi-bin/gnatsweb.pl?cmd=view%20audit-trail&pr=4155
>
> They also won't accept patches unless they've been thoroughly tested,
> so let's agree on gcc and glibc patches, and use them for a few months.
> If no problems pop up, let's submit them.
>
> I've updated http://www.kegel.com/xgcc3/ppc405erratum77.html with the
> above information.

Again, sounds good.

--Mark

> - Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
