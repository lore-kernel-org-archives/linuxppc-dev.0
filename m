Date: Thu, 4 May 2000 10:39:10 -0500 (CDT)
From: john peter grimes <jpgrimes@rainbow.uchicago.edu>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: KDE 2.0 compilation problems
In-Reply-To: <Pine.LNX.4.21.0005040912390.26262-100000@idd-01.imbc.gr>
Message-ID: <Pine.SGI.3.96.1000504103745.744E-100000@rainbow.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas,
	Excellent, that did it, now all of kdelibs installs, onto kdebase
:)
					John
PS Glad to know my gut instinct was right, is this a powerpc specific bug
in gcc or for everyone?

On Thu, 4 May 2000, Kostas Gewrgiou wrote:

> On Wed, 3 May 2000, john peter grimes wrote:
>
> >
> > I was wondering if anyone had tried to compile KDE 2 lately.  I'm trying
> > with yesterdays source and I get the error below in
> > kdelibs/khtml/css
> >
> > I've got an almost standard linuxppc 2000 install which uses gcc-2.95.2-1g
> >
> > I can't find a report of this error on the kde web pages and looking at it
> > I'm almost curious if it could be a problem with gcc for ppc (this file
> > takes forever to compile) or some other ppc specific issue.
> >
>
>   Its a gcc bug, remove the -O2 option and this files will build
> fine.
>
> > Is anyone else compiling kde2, this is my first attempt.
> > 					Thanks,
> > 					John
>
>    Kostas
>
>

           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
