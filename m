Date: Fri, 21 May 2004 14:58:42 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: Lee Braiden <lee_b@member.fsf.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP kernels on single processor machines
In-Reply-To: <40ADF663.1060100@member.fsf.org>
Message-ID: <Pine.LNX.4.56.0405211454220.26114@mag.sysgo.com>
References: <hhad03tlet.fsf@alsvidh.mathematik.uni-muenchen.de>
 <40AC9B08.7010602@member.fsf.org> <1085097417.9801.5.camel@gaston>
 <40ADF663.1060100@member.fsf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 21 May 2004, Lee Braiden wrote:

> Benjamin Herrenschmidt wrote:
>
> > Yah, well... CONFIG_PREEMPT gives you all the problems of SMP without
> > any benefit so .... :)
>
> Well, I know people argue about that, but I think it was you who advised
> me to avoid PREEMPT before, so I'll take your word for it.
>
> But... what you said above was exactly my point.  There are no benefits
> for single-cpu machines running an SMP kernel, right?  So it would
> introduce more complexity for no gain.  Moreover, I think(?) the
> majority of ppc machines are non-smp, so it would also be a shift to a
> more obscure and (even) less well-tested config.

FWIW, CONFIG_PREEMPT _does_ reduce the avarage scheduling latency.
It's still sort of soft real-time, but the effect is measurable (I'm
talking 2.4 kernels here, BTW) However, on desktop systems you
probably don need to worry about this, but for an embedded system you
may like the slightly improved reaction time.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
