From: Larry McVoy <lm@bitmover.com>
Date: Fri, 7 Sep 2001 22:11:28 -0700
Message-Id: <200109080511.f885BSF22039@work.bitmover.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: hosting service change
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, as you know, we host the PPC trees here.  Our 1.5Mbit DSL line
is dieing, the provider went belly up.  We have a backup line which is
.4Mbit/sec and we are getting a real T1 line.  The T1 line is dramatically
more expensive but is supposed to be dramatically more reliable and
consistent.  We're getting it from Global Crossing who have a very nice
set of fibers strung throughout the world.  They commit to, in writing,
100ms ping times to Europe and 60ms ping times to anywhere in the US.
Looks good.  Those are worst case, they claim much better (I've seen
stuff more like 10-20ms in my tests).  And the T1 line is completely
unshared, I have 1.5Mbit/sec to their backbone whether I need it or
not.  That's why it is so much more expensive, DSL shares, T1 doesn't.

I ordered this about 2 weeks ago as soon as the DSL guys indicated they
were dieing; it will be here some time in the next month.

In the meantime, I'll shift the DNS records to point at the slower DSL
line this weekend so you won't be disrupted, it just means somewhat
slower access.  I doubt you'll notice.

As soon as I get the new T1 line, we'll switch over to that.  In any case,
you should not see any loss of access, just somewhat reduced performance
until we get the T1 line.  If you notice problems, let us know.

--lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
