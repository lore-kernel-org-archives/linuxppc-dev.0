Message-Id: <200002090922.BAA28118@work.bitmover.com>
To: Dan Bethe <dan_bethe@yahoo.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: the state of the linuxppc-dev community
In-Reply-To: Your message of "Tue, 08 Feb 2000 17:42:16 PST."
             <20000209014216.17047.qmail@web1001.mail.yahoo.com>
Date: Wed, 09 Feb 2000 01:22:08 -0800
From: Larry McVoy <lm@bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As an aside, Dan, it would be really nice if you made your mail fit in 80
columns.  Lots and lots of people live in 80 column terminals and your mail
is so poorly formatted that I reformat it just to read it.  It also makes it
hard to reply to.

I use a little macro in vi

	map , !}fmt

which says "take the next paragraph and run it through fmt".  See if your
mailer/editor can't do something like that, please.

: > Yeah.  Sorry it's taken so long.  BK is fairly complicated and the problem
: > is that it is a really poor match to the open style of development, in
: > my opinion.  If you guys all use it, it isn't really acceptable to have it
: > break.  Supporting Cort and his buddies on it turned into a big job and it
:
: 	Why is it a poor match?  Is that just because it's currently
: incomplete/unstable, and would spontaneously kill us all?

I wouldn't say that.  We have been using BK to develop BK for about 2.5
years.  It works quite well, actually.

The reason it is a poor match is that a tool like BK is a lot like a file
system - you live on top of it, and when it doesn't work, you don't work.
So having lots of slightly incompatible versions of BK out there would do
nothing but slow down the development.

: 	Is it suitable for fulltime hardcore production use, like
:The Linux Kernel Tree, like your web site says it's intended for?

That's the intent.  And, yeah, I think it is.  It has some rough edges,
you ping Cort to hear about those, but we're getting rid of them.
The architecture of it is very good, we're quite pleased with it and more
than a little proud of it.  It's a lot like stuff you get from Sun - the
first pass shows that the architecture is solid and then over time the
implementation lives up to the architecture.  We're quite close already...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
