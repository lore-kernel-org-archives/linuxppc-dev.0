From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: bug in glibc 2.1.2 new semaphore functions in libpthread?
Date: Tue, 24 Aug 1999 23:09:00 +0200
Content-Type: text/plain
References: <99080116025601.00416@ns1102.munich.netsurf.de> <99082211183400.10683@localhost.localdomain>
In-Reply-To: <99082211183400.10683@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <99082423120101.00862@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Son, 22 Aug 1999 schrieb Kevin Hendricks:
>Hi,
>
>Has anyone tested the new semaphore functions in glibc 2.1.2 in libpthreads? 
>
>If I link the native threads version of the jdk with sem_wait@@GLIC_2.0,
>sem_post@@GLIBC_2.0, etc, they work fine. 
>
>If I link the native threads version of the jdk with the new semaphore
>functions sem_wait@@GLIBC_2.1, sem_post@@GLIBC_2.1 then nothing works at all.
>
>I found this out because I had two binariies from the same source, one of which
>works and the other doesn't and the only difference was that the first (working
>one) was built under an earlier glibc 2.1 while the latter was built with
>Franz's latest glibc 2.1.2.
>
>Upon further investigation with nm I found  that the only difference was in
>which semaphore functions got linked in from libpthread.so.
>
>If it matters, this is in a high signal environment (thread interrupts, thread
>suspension for garabage collection, etc).
>
>I had to drop back to glibc 2.1.1 and rebuild to get the
>native_threads to start working again (so that they would link with the old
>sem_* functions and not the new).
>
>Has anyone really tested the new semaphore functions?  Are they known to be
>broken?  
>
>Any ideas here?

Kevin, the glibc-2.1.2 RPM's are work-in-progress. They generally work well for
me and others, but it may very well be that things are temporarily broken.
Please test the new 4a build. If your problem persists I'll forward it to the
glibc maintainers.

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
