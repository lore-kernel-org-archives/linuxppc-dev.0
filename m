Message-ID: <3A96563E.DE3599E0@valinux.com>
Date: Fri, 23 Feb 2001 23:23:26 +1100
From: Gareth Hughes <gareth@valinux.com>
MIME-Version: 1.0
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: "Timothy A. Seufert" <tas@mindspring.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com> <v04220800b6bbb8f01525@[10.0.0.42]> <3A96553F.B0485736@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> Beware that I have merged in locally some fixes from the trunk which seem to
> help for some problems I had - Gareth, will we merge the branch into the trunk
> anytime soon or should I commit those to the branch?

Jeff Hartmann has informed me he'll be merging it in RSN.

> The only issues I'm seeing now are broken lighting textures in quake-gl,
> missing texture in xtraceroute and garbage at the top of the framebuffer
> periodically. The last also causes a delay so I suspect it's some DMA
> operation going wrong and the driver hitting a timeout, unfortunately I don't
> have time to track it down and probably won't have for weeks. :(

Once we get everything on the trunk, we should look into these more.
There may already be fixes on the trunk for these problems -- the branch
was created a while ago now.

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
