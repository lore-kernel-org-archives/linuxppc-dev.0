Mime-Version: 1.0
Message-Id: <p05100300b781995764c0@[10.0.1.111]>
In-Reply-To: <Pine.LNX.4.05.10107230857310.14709-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10107230857310.14709-100000@callisto.of.borg>
Date: Mon, 23 Jul 2001 02:28:56 -0700
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Larry McVoy <lm@bitmover.com>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: kernel ftp ?
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:07 AM +0200 7/23/01, Geert Uytterhoeven wrote:
>On Sun, 22 Jul 2001, Larry McVoy wrote:
>>  > fact, BK takes MORE bandwidth than rsync on a 'clone' operation because it
>>  > has to ship the complete revision history along.
>>
>>  Wow.  Amazing insight, that.  You could say "copying 100MB takes MORE
>>  bandwidth than copying 50MB because you have to ship the second 50MB",
>>  and that would be an equally amazing insight.
>
>Yes, indeed we're comparing apples to oranges (I think that's how
>you say it in
>English, in Dutch we compare apples to lemons :-)
>
>We developers do want the extra 50 MB, but mere mortals don't. They
>just want a
>copy of the latest version of the tree. Hacking is beyond their capabilities.

Larry, would it be even remotely feasible to add a feature to bk that
checks out just the current state of the tree with no revision
history?  Or do repositories have to be identical up to the branching
point of the last mutual push/pull?  Maybe it could be done by
creating a special kind of repository that can only pull things from
the parent?

I'm thinking something along the lines of the client having no SCCS
files, sort of like doing a bk export from the server repository to
the client's machine.  Unlike export there would also be tag
information for future reference when the server needs to figure out
what's new for the client.  You could call the client side command
"bk rsync".  :)

I'm way out of my depth here so I have no idea if this is possible or
how much work it would entail.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
