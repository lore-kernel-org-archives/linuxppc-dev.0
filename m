To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Greg Weeks <greg.weeks@timesys.com>
Subject: Re: threaded core dump oops
References: <87zna7fzfv.fsf@dedasys.com>
	<20040323212448.GD2330@smtp.west.cox.net>
From: davidw@dedasys.com (David N. Welton)
Date: 24 Mar 2004 13:25:55 +0100
Message-ID: <87y8pqa0to.fsf@dedasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> writes:

> > [ Please CC replies to me - thanks! ]

> > Hi,

> > Looking around, after bumping into this bug myself I found this:

> > http://www.ussg.iu.edu/hypermail/linux/kernel/0402.3/0566.html

> > and was wondering if it will be going in anytime soon.  If not, is
> > there anything I can do to help?  I can reproduce the Oops
> > reliably...

> Probably in time for 2.6.6-rc1 (I'm trying to take the term "release
> candidate" seriously, at least for what I'm passing along).  A
> simple program which causes the oops would be quite helpful, too.

Well, it's not as simple as a small C program, but this will do the
job on Debian testing (*):

echo "package require Expect" | tclsh8.4

The problem is that Tcl 8.4 is threaded, Expect isn't, and something
goes wrong when Expect gets loaded into Tcl.

--
David N. Welton
   Consulting: http://www.dedasys.com/
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/

(*) If no one uploads an updated Expect package anytime soon, the bad
    version is: 5.39.0-1

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
