Date: Tue, 26 Jun 2001 11:50:42 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc @ ppc.bitkeeper.com
Message-ID: <20010626115042.E9808@work.bitmover.com>
References: <200106261813.f5QID0l244185@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200106261813.f5QID0l244185@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Jun 26, 2001 at 02:13:00PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > We're working getting BK/web up and we are also making changes so that you'll
> > be able to do this:
> >
> >         bk clone http://ppc.bitkeeper.com/linuxppc_2_4
> >
> > which will work through firewalls.
>
> *sigh*
>
> Encouraging people to violate security?

A) It's not a security violation in any way.  Not unless running netscape
   or IE is a security violation.  Lots of people are behind firewalls
   that shut down everything except port 80.  What do you want us to do?
   Mount some windmill tilting campaing against the people managing the
   firewalls?  What if they have legit reasons for doing it that way?
   Most people are grateful that we make this easy for them, what's your
   complaint with that?  And is this the place to discuss it?

B) *We* don't care what port you use.  We support http access, ssh access,
   rsh access, email access, bkd access, local file access, you name it,
   we support it.  So whining about it here like we are encouraging security
   problems when there are no security problems, and the restrictions are
   not of our doing is a little annoying.  Take it up with IBM, not us, we
   didn't cause the problem, we just provide a solution.

> bzip2 -dc patches-are-better.bz2 | patch -p1 -E -s
>
> I know it doesn't push BitKeeper, but patches are certainly fine for
> bandwidth problems.

We're not here to push BitKeeper, we're just providing a service.  If you
like running patch and fixing up the patch problems, be my guest.  Patch
doesn't always work, but BK patches _always_ work.  If BK patches don't
work, that's a bug, if patch patches don't work, that's a limitation of
diff/patch.  We're agnostic about what you use.

> I'm not even sure if I'm allowed to use BitKeeper. I'm doing some
> work with the Linux kernel, but I can't make it public yet and
> getting the paid license would be quite a pain. (while the actual
> dollar amount isn't likely an issue, getting a purchase order
> and MIS approval would be an awkward procedure -- around here
> ClearCase rules)

So don't use it then, no one is asking you to do so.

Let's get something perfectly clear: we provide free use of BK as a service.
If you want to use, that's great, we appreciate the bug reports and the
good will.  If you don't want to use it, that's fine too, but I fail to see
why the rest of the list needs to know that.

Let's make that really clear: if there is some reason that you can't
use BK and you want that fixed, take it up with support@bitmover.com or
sales@bitmover.com, not the ppc lists.  Nobody on those lists wants to
see an endless discussion of the pros and cons of BK.

If I seem a little touchy about this, I am.  I've been burned before by
being dragged into this sort of discussion and I end up looking some rabid
marketing person.  I'm not interested in doing that, and I'm positive that
the ppc lists aren't interested in having that happen here, so I think
everyone would appreciate it if the BK merits (or lack thereof) were
discussed elsewhere.  I'm quite happy to address any of your concerns,
or anyone else's concerns, in private email, but let's keep the list
focussed on PPC.

Thanks,
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
