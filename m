Mime-Version: 1.0
Message-Id: <p0510030ab8c8fb48c50c@[63.220.231.138]>
In-Reply-To: <20020328141439.20362@mailhost.mipsys.com>
References: <E16qa5v-0000NT-00@piglet.grunz.lu>
 <20020328141439.20362@mailhost.mipsys.com>
Date: Thu, 28 Mar 2002 12:02:53 -0500
To: benh@kernel.crashing.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: xmon feature? (was Re: crash on sleep with 2.4.19-pre4-ben0)
Cc: <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >How? The keyboard doesn't work under xmon.... I need to power-cycle.
>
>You can try manually adding a call to backtrace() in xmon entry point

I tried this once but never got it to work. No doubt because I don't
know much about what I'm doing in kernel programming yet.

I'd like to suggest this feature: that by default xmon prints a
backtrace when it is invoked. A user can then ask it for any more
info they want (including the backtrace again).

This would largely alleviate the general problem of losing keyboard
control and having to powercycle without getting much info out.

Is there a reason to object to this idea? xmon maintainers won't go
for it? Automatic backtraces might be too large? Other reasons I
might never imagine on my own? The kernel automatically does it on a
boot panic, I know that much.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
