Subject: Re: how to setup PLL1 on 750FX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Studholme <cvs@cs.utoronto.ca>
Cc: Terry Greeniaus <tgree@phys.ualberta.ca>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.44.0306301448490.12550-100000@stoa.dhs.org>
References: <Pine.LNX.4.44.0306301448490.12550-100000@stoa.dhs.org>
Content-Type: text/plain
Message-Id: <1057053169.32104.300.camel@gaston>
Mime-Version: 1.0
Date: 01 Jul 2003 11:52:49 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-06-30 at 20:57, Chris Studholme wrote:
> On Sat, 28 Jun 2003, Benjamin Herrenschmidt wrote:
> > Looks good. Just fix the cpu_setup_6xx.S code so that sleep mode
> > works properly and it should be ok to merge upstream.
>
> Oddly enough, sleep mode was working without HID1 and HID2 being saved;
> however, I was occationally getting non-reproducable hangs on resume.
> I've changed __save_cpu_setup and __restore_cpu_setup in cpu_setup_6xx.S
> to use real_pvr now.  Sleep/resume works fine from both high speed and low
> speed.  Also, I moved the setup of PLL1 to setup_750fx in cpu_setup_6xx.S.

There are small bits of non-unified diffs in there, can you resend with
only unified (-u) diffs ? Thanks !

I'll apply to my next release and maybe to 2.4.22

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
