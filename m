Message-ID: <3D1C9FBA.24AF9045@mvista.com>
Date: Fri, 28 Jun 2002 13:41:14 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Allen <gallen@arlut.utexas.edu>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_BLOCK_DEV_RAM in linuxppc_2_4_devel
References: <Pine.GSO.4.21.0206281716390.14426-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> On Fri, 28 Jun 2002, Greg Allen wrote:
> > I just did a bk pull on my modified linuxppc_2_4_devel tree, and it
> > no longer compiles.
> >
> > snippit from init/do_mounts.c, line 381
> >
> >     #if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
> >     static void __init change_floppy(char *fmt, ...)
> >     {
> >
> >
> > The linker complains that this function should be present.
> >
> > I have CONFIG_BLK_DEV_RAM turned on, and no floppy. I can't find any
> > other reference to CONFIG_BLOCK_DEV_RAM.
> >
> > Is this simply a typo that never got tested without CONFIG_BLK_DEV_FD
> > turned off?
>
> Must be CONFIG_BLK_DEV_RAM.

I fixed it and pushed the changeset yesterday.  Do another bk pull.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
