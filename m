From: Thomas H?henleitner <th@visuelle-maschinen.de>
Reply-To: th@visuelle-maschinen.de
To: James Simmons <jsimmons@acsu.buffalo.edu>
Subject: name space pollution Was Re: [linux-fbdev] CTFB 0.30 now availiable (CT65554...CT69000)
Date: Tue, 20 Jun 2000 11:03:42 +0200
Content-Type: text/plain
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Adrian Cox <apc@agelectronics.co.uk>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.10.10006191510001.455-100000@maxwell.futurevision.com>
In-Reply-To: <Pine.LNX.4.10.10006191510001.455-100000@maxwell.futurevision.com>
MIME-Version: 1.0
Message-Id: <00062011283507.10856@iris>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Mon, 19 Jun 2000 schrieb James Simmons:

> I got it now thanks to Geert. You have alot of files for ctfb.
>

It's a matter of taste. A file overview is in ctfb_README. And no big deal to
merge them into one monolitc block if it should go into the kernel sources.

By the way I have here a question:

If we have several submodules as parts of a framebuffer we have some symbols
within the namespace of this framebuffer. When we compile it as a separate
module for modprobe there is no problem. But when we compile it as part of the
kernel these frambuffer specific symbols are polluting the kernel namespace. Is
there an elegant way to make the framebuffer specific symbols invisible for the
kernel after we have  our xxxfb.o?

Thomas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
