From: linas@austin.ibm.com
Date: Mon, 2 Jun 2003 11:47:16 -0500
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Linas Vepstas <linas@linas.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel Panic in 2.2.x
Message-ID: <20030602114716.C36746@forte.austin.ibm.com>
References: <20030531005832.GA4272@backlot.linas.org> <E985F997-9509-11D7-BBCD-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E985F997-9509-11D7-BBCD-000A95A0560C@us.ibm.com>; from hollisb@us.ibm.com on Mon, Jun 02, 2003 at 09:53:03AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 02, 2003 at 09:53:03AM -0500, Hollis Blanchard wrote:
>
> However, don't complain that upgrading your system can make things
> break and ask me for sympathy. :) I for one would rather spend my time
> making things work than making things backwards-compatible back to

Well, part of the problem is, of course, that things that used to
work in old versions sometimes don't work in newer versions.  No
one will argue that 'making things work' isn't a good intention,
but, by itself, it is not enough to make an effective process.

Everyone has good intentions, but accidents still happen.  You say
that you want to drive 100 mph, and you think I'm saying 'everyone
must drive 55 mph'.  That's not what I'm saying.  I'm trying to talk
about what it takes to drive 100 mph *safely*.

> version 0.3. I guess you're trying to convince me of the exact
> opposite, but IMHO there's simply too much stuff left to get working.
> Once it all works

Surely, you know that that day will never, ever come!  You do understand
that, don't you?

> then we can talk about

That's like saying "once we have eliminated all wars and killing,
only then shall we start to think about medicine and health care!"

> backwards-compatibility... ;)

I don't think you understood what I'm saying.  Its not about backwards
compatibility.  Backwards-compat can help, but its *NOT* what I'm
talking about.   Did I actually use the words 'backwards compatible'
anywhere in any of my series of notes on this topic?  I don't think so!

Part of what I'm talking about is technology, like having an installer
that allows you install the new version without trashing the old version,
so that the new version can be backed out if it doesn't work.  I think
AIX has an installer like this (I've never used it).  Linux doesn't.

Part of what I'm talking about is a change of attitude, such as the
idea that maintaining and patching the 2.2 kernel is wrong.  It's
not wrong, and there are some very good technical reasons for
maintaining this kernel/code base.

--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
