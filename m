Date: Tue, 20 Jun 2000 19:40:32 -0400 (EDT)
From: James Simmons <jsimmons@acsu.buffalo.edu>
To: Thomas HXhenleitner <th@visuelle-maschinen.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Adrian Cox <apc@agelectronics.co.uk>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: name space pollution Was Re: [linux-fbdev] CTFB 0.30 now availiable
 (CT65554...CT69000)
In-Reply-To: <00062011283507.10856@iris>
Message-ID: <Pine.LNX.4.10.10006201939080.2081-100000@maxwell.futurevision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> If we have several submodules as parts of a framebuffer we have some symbols
> within the namespace of this framebuffer. When we compile it as a separate
> module for modprobe there is no problem. But when we compile it as part of the
> kernel these frambuffer specific symbols are polluting the kernel namespace. Is
> there an elegant way to make the framebuffer specific symbols invisible for the
> kernel after we have  our xxxfb.o?

Hum? I don't know. Anyone? I usually don't think about namespace
pollution. I just makes sure I bizarre names so they don't conflict with
anything else.

Q: Why did they deprecate a.out support in linux?
A: Because a nasty coff is bad for your elf.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
