Message-ID: <40ADF663.1060100@member.fsf.org>
Date: Fri, 21 May 2004 13:30:27 +0100
From: Lee Braiden <lee_b@member.fsf.org>
MIME-Version: 1.0
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP kernels on single processor machines
References: <hhad03tlet.fsf@alsvidh.mathematik.uni-muenchen.de>	 <40AC9B08.7010602@member.fsf.org> <1085097417.9801.5.camel@gaston>
In-Reply-To: <1085097417.9801.5.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> Yah, well... CONFIG_PREEMPT gives you all the problems of SMP without
> any benefit so .... :)

Well, I know people argue about that, but I think it was you who advised
me to avoid PREEMPT before, so I'll take your word for it.

But... what you said above was exactly my point.  There are no benefits
for single-cpu machines running an SMP kernel, right?  So it would
introduce more complexity for no gain.  Moreover, I think(?) the
majority of ppc machines are non-smp, so it would also be a shift to a
more obscure and (even) less well-tested config.

--
Lee Braiden
lee_b@member.fsf.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
