Date: Tue, 23 Mar 2004 14:24:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David N. Welton" <davidw@dedasys.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Greg Weeks <greg.weeks@timesys.com>
Subject: Re: threaded core dump oops
Message-ID: <20040323212448.GD2330@smtp.west.cox.net>
References: <87zna7fzfv.fsf@dedasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zna7fzfv.fsf@dedasys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 23, 2004 at 02:47:00PM +0100, David N. Welton wrote:

>
> [ Please CC replies to me - thanks! ]
>
> Hi,
>
> Looking around, after bumping into this bug myself I found this:
>
> http://www.ussg.iu.edu/hypermail/linux/kernel/0402.3/0566.html
>
> and was wondering if it will be going in anytime soon.  If not, is
> there anything I can do to help?  I can reproduce the Oops reliably...

Probably in time for 2.6.6-rc1 (I'm trying to take the term "release
candidate" seriously, at least for what I'm passing along).  A simple
program which causes the oops would be quite helpful, too.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
