To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx SCC and SMC uart latency 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Jan 2003 08:00:28 EST."
             <5.1.0.14.2.20030115075248.02669e88@falcon.si.com>
Date: Wed, 15 Jan 2003 14:13:39 +0100
Message-Id: <20030115131344.CBEF5C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.0.14.2.20030115075248.02669e88@falcon.si.com> you wrote:
>
> The idea is that your processing task waits on a semaphore: when someone
> has something for it to do, they release (post/signal) the semaphore which
> unblocks the processing task.  This allows the processing task to (a) not
> consume processor resources when it doesn't have anything to do and (b)
> start up immediately when there is something to do (as opposed to having to
> wait for its slice of processor time).

Since serial and network I/O are involved, the "semaphore"  might  be
as simple as a select(), of course.

But that does not fix any scheduling latencies.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Work 8 hours, sleep 8 hours; but not the same 8 hours.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
