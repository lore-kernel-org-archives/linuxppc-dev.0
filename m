From: miles.lane@comcast.net
Message-Id: <200308071600.LAA12220@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.0-test2 -- The Uninorth Agpgart driver code contains no author info.
Date: Thu, 07 Aug 2003 16:00:00 +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ah, I see.  I was searching for an e-mail address.
This new approach maps the name to a value in the MAINTAINERS file, right?
I am guessing this helps reduce the number of stale e-mail addresses
that are embedded in the code.  Will we eventually overhaul the whole
codebase to use this method?

All the best,

     Miles

> On Thu, 2003-08-07 at 06:44, Miles Lane wrote:
> > This makes it rather difficult to know who to contact to request
> > that the Uninorth support get put into Marcelo's 2.4 tree.
> >
> > Oh, and there is also no GPL header in those files.
>
> Look at the end of file:
>
> MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
> MODULE_LICENSE("GPL");

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
