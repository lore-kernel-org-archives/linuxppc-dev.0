To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <debian-powerpc@lists.debian.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: "Cache Profiler" ? (was: No cache control on ppc??)
References: <877kqmvfmy.fsf@yahoo.com> <20020113193619.14166@smtp.wanadoo.fr>
From: Elizabeth Barham <soggytrousers@yahoo.com>
Date: 15 Jan 2002 03:17:32 -0600
In-Reply-To: Benjamin Herrenschmidt's message of "Sun, 13 Jan 2002 20:36:19 +0100"
Message-ID: <87vge455xv.fsf@liliwhite.open.oasis>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> First boot once with BootX. Once in linux, grab the value of
> /proc/sys/kernel/l2cr. Then, go back to quik, and in your boot
> scripts, write back this value. This is the configuration of the
> backside L2 cache of the 750.

Just a follow-up:

It turns out that Linux was using the 750 processor with it's
configuration (1,0,0,1 [NewerTech G3L2]) but it was not using the
cache at all. In order to grab the parameters of the above-mentioned
file in the /proc/sys/kernel directory I had to install Mac
OS. Fortunatly we had an extra drive available to install it upon.

The configuration that I had been using, though, disabled the cache so
I had to find a better setting that was quicker and stable (0,0,1,0
[240 MHz, 478.41 bogomips]). However, the gotcha! with this is that
quik (v2.0) throws a fatal error prior to the start-screen ("Choose
your kernel").

So, I ended up just keeping MacOS on half of the newly-installed drive
and will use BootX to boot into Linux now and in the future; it's not
*that* inconvenient and the increase in speed is easily worth it.

Thank you all for your help.

Kind regards, Elizabeth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
