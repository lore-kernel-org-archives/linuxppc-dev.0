Date: Mon, 9 Aug 2004 12:03:19 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Wolfgang Denk <wd@denx.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4 versus 2.6 patches
Message-ID: <20040809150319.GD5733@logos.cnet>
References: <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain> <20040726171608.12880C109F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040726171608.12880C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang!

On Mon, Jul 26, 2004 at 07:16:03PM +0200, Wolfgang Denk wrote:
>
> In message <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain> you wrote:
> >
> > Deployment if you're already almost ready to ship is sane enough, I
> > suppose -- but to actually put more effort into 2.4 wouldn't make much
> > sense.
>
> It depends on your requirements.
>
> If you need a kernel that is
> 	(1) stable and working [2.6 is still pretty much useless for  example
> 	    on  8xx  systems],
> 	(2) small [2.6 is usually >= 20% bigger than 2.4],
> and/or

Even with CONFIG_EMBEDDED or Matt Mackall's -tiny tree?

> 	(3) fast [2.6 is usually >= 10% slower than 2.4],
> then 2.4 may be the better choice.

Where are you you seeing this slowdown?

v2.6 is faster in almost all workloads (it often consumes less memory, VM/FS/core API's
are faster, etc).

rkload, and we are talking about embedded setups/workloads here.

So, I'm sure we should go hunt the slowdowns... At least make the kernel development
community known about them. For sure we should make efforts to fix any performance
regressions in v2.6.

> > Because nobody's really that interested in it. For what it's worth, I've
> > abandoned all pretence of continuing to support 2.4 in the MTD/JFFS2 CVS
>
> David, you can do what you want. But it is not up to  you  to  decide
> what  other people are doing. I declare that there ARE people who are
> interested in 2.4 kernel - both for maintenance and development work.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
