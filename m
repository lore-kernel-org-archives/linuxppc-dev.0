From: benh@kernel.crashing.org
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xmon feature? (was Re: crash on sleep with 2.4.19-pre4-ben0)
Date: Thu, 28 Mar 2002 18:19:53 +0100
Message-Id: <20020328171953.1200@mailhost.mipsys.com>
In-Reply-To: <p0510030ab8c8fb48c50c@[63.220.231.138]>
References: <p0510030ab8c8fb48c50c@[63.220.231.138]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I tried this once but never got it to work. No doubt because I don't
>know much about what I'm doing in kernel programming yet.
>
>I'd like to suggest this feature: that by default xmon prints a
>backtrace when it is invoked. A user can then ask it for any more
>info they want (including the backtrace again).
>
>This would largely alleviate the general problem of losing keyboard
>control and having to powercycle without getting much info out.
>
>Is there a reason to object to this idea? xmon maintainers won't go
>for it? Automatic backtraces might be too large? Other reasons I
>might never imagine on my own? The kernel automatically does it on a
>boot panic, I know that much.

I think it didn't work because for some reason, the backtrace
didn't work at this point (that is it wouldn't have worked from
xmon prompt neither). THat can happen in some situations.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
