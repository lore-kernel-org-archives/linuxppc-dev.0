Message-ID: <40AC9B08.7010602@member.fsf.org>
Date: Thu, 20 May 2004 12:48:24 +0100
From: Lee Braiden <lee_b@member.fsf.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: SMP kernels on single processor machines
References: <hhad03tlet.fsf@alsvidh.mathematik.uni-muenchen.de>
In-Reply-To: <hhad03tlet.fsf@alsvidh.mathematik.uni-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jens Schmalzing wrote:

>SMP kernels run
>fine on single processor machines.  I have repeatedly been told,
>however, that this bears a considerable performance hit on some
>hardware.  Can anybody confirm or deny this?  Even small hints would
>be appreciated.
>
>
A long time ago, I used to compile SMP into my kernels just on the
coolness factor, and on the promise that 'one day, soon, I'll get me a
decent machine' :)

But I quit doing that at some point, after someone (authoritative, but I
can't remember the details) pointed out that it added complexity,
debugging issues, etc.  Given that I *already* have problems with PPC
kernels -- latency/lockups, (preempting?), alsa sound, video res, etc.,
I personally wouldn't go near this until I'm fairly confident that the
other stuff is solid in its own right.

But then, I'm just a luser, not a kernel maintainer ;D

--
Lee Braiden
lee_b@member.fsf.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
