Subject: Re: SMP kernels on single processor machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Braiden <lee_b@member.fsf.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <40AC9B08.7010602@member.fsf.org>
References: <hhad03tlet.fsf@alsvidh.mathematik.uni-muenchen.de>
	 <40AC9B08.7010602@member.fsf.org>
Content-Type: text/plain
Message-Id: <1085097417.9801.5.camel@gaston>
Mime-Version: 1.0
Date: Fri, 21 May 2004 09:56:58 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-05-20 at 21:48, Lee Braiden wrote:

> But I quit doing that at some point, after someone (authoritative, but I
> can't remember the details) pointed out that it added complexity,
> debugging issues, etc.  Given that I *already* have problems with PPC
> kernels -- latency/lockups, (preempting?), alsa sound, video res, etc.,
> I personally wouldn't go near this until I'm fairly confident that the
> other stuff is solid in its own right.
>
> But then, I'm just a luser, not a kernel maintainer ;D

Yah, well... CONFIG_PREEMPT gives you all the problems of SMP without
any benefit so .... :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
