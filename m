Subject: Re: SMP kernels on single processor machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marius Groeger <mgroeger@sysgo.com>
Cc: Lee Braiden <lee_b@member.fsf.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.56.0405211454220.26114@mag.sysgo.com>
References: <hhad03tlet.fsf@alsvidh.mathematik.uni-muenchen.de>
	 <40AC9B08.7010602@member.fsf.org> <1085097417.9801.5.camel@gaston>
	 <40ADF663.1060100@member.fsf.org>
	 <Pine.LNX.4.56.0405211454220.26114@mag.sysgo.com>
Content-Type: text/plain
Message-Id: <1085181086.8030.9.camel@gaston>
Mime-Version: 1.0
Date: Sat, 22 May 2004 09:11:26 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-05-21 at 22:58, Marius Groeger wrote:

> FWIW, CONFIG_PREEMPT _does_ reduce the avarage scheduling latency.
> It's still sort of soft real-time, but the effect is measurable (I'm
> talking 2.4 kernels here, BTW) However, on desktop systems you
> probably don need to worry about this, but for an embedded system you
> may like the slightly improved reaction time.

Well... average latency is mostly meaningless, only peak latency really
matters for anything that need some sort of real time imho...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
