Mime-Version: 1.0
Message-Id: <p06100201bd4eeaa40658@[192.168.0.23]>
In-Reply-To: <20040821225118.GB18858@suse.de>
References: <p06100200bd4c49c3daeb@[192.168.0.23]>
 <p06100203bd4c5e3aa6d9@[192.168.0.23]>
 <p06100204bd4c604f23ac@[192.168.0.23]> <20040821225118.GB18858@suse.de>
Date: Sun, 22 Aug 2004 20:54:07 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.6 hoses 2.4 on old-world?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering:

>the binutils check (?) will remove /dev/null

Well, I found your earlier thread on binutils and the discussion of
the -many switch, but I'm not clear as to what this is all about. It
looks like my problem is two-fold:

1. To build 2.6.x, I need a newer binutils than my 2.13.90.0.18-6 (YDL 301)
2. The as check fails to tell me my binutils is too old (?)

Is this correct? Since I don't see the error, what version of
binutils do I need? Just the "latest?" Not having done so yet, will I
have to upgrade various other things as well? (gcc, etc).

Sam Ravnborg:

>Yep - Tom Rini already notified me about this issue.
>Problem is the way as handle output files.

I think this is the same thread I was talking about. What I'm really
unclear on is the "correct" way to handle this. It seems like the
discussion about changing AFLAGS is still alive? Also from the
earlier thread, it seems like maybe the latest binutils will not
necessarily fix the issue, as something has changed in binutils?

Sorry to be such a newbie on this. I'm obviously 2-3 months behind
the discussion, just now delving into 2.6...


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
