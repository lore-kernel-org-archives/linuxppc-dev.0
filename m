Message-ID: <3A96553F.B0485736@iiic.ethz.ch>
Date: Fri, 23 Feb 2001 13:19:11 +0100
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: Gareth Hughes <gareth@valinux.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com> <v04220800b6bbb8f01525@[10.0.0.42]>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:

> Any suggestions?  If anybody wants to see some logs from the server
> starting up, I'll supply 'em.  Also, if anybody out there has gotten
> this working, could you send me your XF86Config so I can make sure I
> didn't do something silly to mine?

http://n.ethz.ch/student/daenzerm/download/DRI/XF86Config

is what I use on my Pismo.


Beware that I have merged in locally some fixes from the trunk which seem to
help for some problems I had - Gareth, will we merge the branch into the trunk
anytime soon or should I commit those to the branch?

The only issues I'm seeing now are broken lighting textures in quake-gl,
missing texture in xtraceroute and garbage at the top of the framebuffer
periodically. The last also causes a delay so I suspect it's some DMA
operation going wrong and the driver hitting a timeout, unfortunately I don't
have time to track it down and probably won't have for weeks. :(

Otherwise it works great for me!


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
