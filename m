From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 3 Aug 2004 10:00:47 +0200
To: Stef Simoens <stef.simoens@pi.be>
Cc: Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] align.c
Message-ID: <20040803080047.GC27809@iram.es>
References: <40F57D15.8030700@pi.be> <69A5B0EA-D669-11D8-A9B5-000393DBC2E8@freescale.com> <40F8138F.8090004@pi.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40F8138F.8090004@pi.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 16, 2004 at 07:42:39PM +0200, Stef Simoens wrote:
>
> Kumar Gala wrote:
> >Do you really see string ops and alignment exceptions?  I was under the
> >impression they did byte accesses.
>
> Yes, but i've only seen alignment exceptions with stswi/lswi
> instructions though.
>
> (On the MPC601, stswi/lswi has better timings than a series of stw/lwz;
> that's why I'm probably the only one seeing them...)
>
> While I was at it, Paulus asked me to handle stmw/lmw and stswx/lswx as
> well...

Personnaly I disagree for stmw/lmw, they are specified to
work only for word-aligned addresses.

	Regards,
	Gabriel (back form holidays, so the delay)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
