Subject: Re: PREEMPT problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin LEROY <colin@colino.net>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
Content-Type: text/plain
Message-Id: <1080865776.1286.8.camel@gaston>
Mime-Version: 1.0
Date: Fri, 02 Apr 2004 10:29:37 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-04-02 at 00:32, Colin LEROY wrote:
> Hi,
>
> This won't be really helpful, as I have no time to investigate, but I seem
> to have problems with preempt (and latest main-tree BK). After a few hours
> of uptime, I get hanging processes (sed, cvs (can't be network related as
> the CVSROOT is local)) and gcc segfaults while compiling kernel.
>
> Maybe it's not completely fixed yet...

Ah. Well, no problem here nor for other testers so far, weird...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
