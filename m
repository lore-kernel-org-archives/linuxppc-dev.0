From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Elizabeth Barham <soggytrousers@yahoo.com>
Cc: <debian-powerpc@lists.debian.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: "Cache Profiler" ? (was: No cache control on ppc??)
Date: Sun, 13 Jan 2002 20:36:19 +0100
Message-Id: <20020113193619.14166@smtp.wanadoo.fr>
In-Reply-To: <877kqmvfmy.fsf@yahoo.com>
References: <877kqmvfmy.fsf@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I recently installed a NewerTech Maxpowr G3 L2-Cache - which is a G3
>on a board that fits into one of the L2's ram banks on my Starmax
>3000/160. I was ecstatic that the bogomips increased by 187%
>(199.47). Recently, though, I heard of someone installing a JoeBoard
>into his StarMax 5000 and his bogomips being around 800. He mentioned
>something about a "Cache Profiler". It seems that BootX is somehow
>able to tell the kernel that there is a G3 in the cache and speed is
>increased greatly.
>
>The CPU on the StarMax 3000/160 motherboard itself (what originally
>came with it) is a PPC 603e. /proc/cpuinfo shows a 750 - which is good
>but the bogomips are nowhere near what this person reported.  I do not
>use BootX for I prefer booting straight into Linux with Quik.  Does
>anyone know anymore about this and if it's possible to increase
>performance more by somehow making the G3 quicker?

First boot once with BootX. Once in linux, grab the value of
/proc/sys/kernel/l2cr. Then, go back to quik, and in your
boot scripts, write back this value. This is the configuration
of the backside L2 cache of the 750.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
