Message-ID: <40352CB0.1060100@jonmasters.org>
Date: Thu, 19 Feb 2004 21:37:52 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Solution Update [WAS: Re: EDK6.1 vs. EDK3.2 clarification]
References: <1036q23btu3ru01@corp.supernews.com> <4033A0D7.1050005@jonmasters.org>
In-Reply-To: <4033A0D7.1050005@jonmasters.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi there,

I thought it prudent to update anyone who later reads this thread as to
the cause and outcome of this issue which was ongoing for a while.

It turns out that I had not correctly initialised the cache controller
in my firmware and today was able to prove that this had worked on the
old hardware generated with EDK3.2 however this was not the case with
EDK6.1 for whatever reason. It was not the Linux kernel at fault.

Perhaps I could moan about the various documentation and other issues
but it comes down to a bit of code which got changed at some point,
continued to work ok but later caused a hiccup with new hardware as the
data cache not being properly flushed on startup resulted in fun.

Bottom line is I now once more have a fully working Insight Memec V2P
port with EDK6.1 hardware and our custom modules are now in again.

I think someone else had similar symptoms...

Cheers,

Jon.

P.S. Thanks for reading.

P.P.S. I am going to FOSDEM in the morning if anyone cares.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
