Message-ID: <3A6BB971.7F128273@rochcivictheatre.org>
Date: Sun, 21 Jan 2001 22:39:13 -0600
From: Tom Gall <tgall@rochcivictheatre.org>
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: Dan Malek <dan@mvista.com>, linuxppc_commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com> <20010121222842.A27103@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:

> On Fri, Jan 19, 2001 at 09:27:44PM -0500, Dan Malek wrote:
> >
> > I just heard about the bug Tom Gall fixed in "context_overflow"
> > by testing for current->mm == NULL.
> >
> > I believe the proper solution is to use 'current->active_mm'
> > instead of 'current->mm' (and you never get a null pointer).
> > This way, the proper 'active' context is updated with a new
> > context even though a kernel thread has stolen it from somewhere
> > else to use.  I think skipping the selection of a new context
> > in this case could be logically incorrect for some PowerPC cores.
>
> Since this got no response, I'm cross-posting to linuxppc-commit.

I will look into this tomorrow.  It's an important fix, I don't want to rush.


> So, does anyone else have any comments on this? This appears to be something
> that's going to be quite hard to track down if we don't get it right..
> So what's the right answer before we forget about it again and go on?
>
> And on that note... what do we have for bug-tracking systems for ppc kernel
> related stuff? The collective memory of people on these to mailing lists?
> I know someone mentioned a sourceforge page at one point.. is anyone useing that?

There is a sourceforge page. It hasn't been active which probably isn't a good
thing. I know I'm keeping a bug list on paper that I know about. It's not a long
list.  Happy to put it out on sourceforge...  just don't want it all to be a waste
of time tho. I'm sure Olaf might have a bug or two to contribute 8-)

https://sourceforge.net/projects/ppclinux/

--
Hakuna Matata,

Tom

-----------------------------------------------------------
PPC Linux Guy      "My heart is human, my blood is boiling,
                    my brain IBM" -- Mr Roboto, Styxx
tgall@rochcivictheatre.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
