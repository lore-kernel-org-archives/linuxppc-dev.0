Date: Thu, 3 Jun 2004 13:48:04 -0700
From: Matt Porter <mporter@KERNEL.CRASHING.ORG>
To: Sylvain Munaut <tnt@246tnt.com>
Cc: Tom Rini <trini@KERNEL.CRASHING.ORG>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: DMA support for MPC5xxx?
Message-ID: <20040603134804.B24468@home.com>
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de> <20040603113302.A24468@home.com> <20040603185053.GN15195@smtp.west.cox.net> <40BF87BB.4020808@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40BF87BB.4020808@246tNt.com>; from tnt@246tnt.com on Thu, Jun 03, 2004 at 10:19:07PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 03, 2004 at 10:19:07PM +0200, Sylvain Munaut wrote:
>
>  >>> See the thread starting at
>  >>> http://lists.linuxppc.org/linuxppc-dev/200311/msg00000.html
>  >>>
>  >>> David even posted on this list to get feedback  from  the
>  >>> community. But I haven't seen a single reply on the mailing
>  >>> lists.
>  >>
>  >> So? Repost. I miss stuff the first time around a lot of times
>  >> myself [this is not to indicate that I would necessarily comment
>  >> on 5200 stuff, just an example].
>  >
>  >
>  > And this time do it against 2.6.  Even if 2.4 wasn't necessarily
>  > frozen at the time we first tried, it is now.
>
> Actually I got some patch to support MPC5200 ( and only this one, no
> mgt5100 stuff ) for 2.6
> It only supports booting, serial console and i2c. Not much but could
> that be put in official tree if I submit it ? Or does it need to
> support  more than that to worth inclusion.
> So that at least if someone tries to implement more ( I'll resume my
> work on it in a few weeks ), it has a base already in official tree.

Why not? You're the only one showing interest in supporting 5200 in
2.6. Post the patch and if it's clean it can go in. The "i2c", I
assume, is an i2c host adapter driver so that needs to be separated
so it can go to gregkh. Don't lump it in with the include/asm-ppc
and arch/ppc core support. :)

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
