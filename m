Subject: Re: PREEMPT problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin LEROY <colin@colino.net>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
Content-Type: text/plain
Message-Id: <1080867387.1203.19.camel@gaston>
Mime-Version: 1.0
Date: Fri, 02 Apr 2004 10:56:27 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-04-02 at 00:32, Colin LEROY wrote:
> Hi,
>
> This won't be really helpful, as I have no time to investigate, but I seem
> to have problems with preempt (and latest main-tree BK). After a few hours
> of uptime, I get hanging processes (sed, cvs (can't be network related as
> the CVSROOT is local)) and gcc segfaults while compiling kernel.

Oh, btw, finding out where those are beeing stuck may help. A good
way to do that is to use xmon "P" command, look at the KSP for one
of those processes (kernel stack pointer) and do a backtrace based
on it with "b <ksp value>"

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
