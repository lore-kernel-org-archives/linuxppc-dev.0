Message-ID: <3AEED6C9.DE676BB3@wanadoo.fr>
Date: Tue, 01 May 2001 17:31:21 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Benh-2.4.4-pre3 kills linuxconf
References: <3ADF422F.CBC1EC7@wanadoo.fr> <20010419201234.23660@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >For a long time, I have been using linuxconf to switch between home and
> >office configurations on my iBook. This worked up to kernel version
> >2.4.4-pre1 (rsynced from the benh tree on April 12). With 2.4.4-pre3,
> >rsynced yesterday, linuxconf doesn't work any more. When I type
> >"linuxconf", it just sits there and waits, doing nothing. When I stop it
> >with ^C, then subsequent calls of linuxconf come back immediately saying
> >"Broken pipe." The kernel config is the same in both cases.
> >
> >Has anyone seen this?
>
> No, but I don't use linuxconf...

I found a small patch for kernel/fork.c on the linux-kernel mailing list
that solves this problem. It seems that others consider the change to
this file that occurred between 2.4.4-pre1 and pre3 a bug, too.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
