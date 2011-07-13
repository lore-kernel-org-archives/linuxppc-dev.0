Return-Path: <anton@samba.org>
Date: Wed, 13 Jul 2011 23:05:46 +1000
From: Anton Blanchard <anton@samba.org>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] hvc_console: Add kdb support
Message-ID: <20110713230546.0a2666aa@kryten>
In-Reply-To: <CA+5PVA7cGL+f94T3VL4NRvMSLD4L5mWn=iYAPujqYcH9aHhOVQ@mail.gmail.com>
References: <20110713154405.297f828d@kryten>
	<CA+5PVA7cGL+f94T3VL4NRvMSLD4L5mWn=iYAPujqYcH9aHhOVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kgdb-bugreport@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
	jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> > Add poll_get_char and poll_put_char for kdb. Enable kdb at boot
> > with:
> 
> Did you mean "...for kgdb.  Enable kgdb at boot.." ?
> 
> I thought kdb and kgdb shared some infrastructure now, but your patch
> and comments seem to be all about kgdb.

No I do mean kdb :) From the Documentation:

   <para>The kgdboc driver was originally an abbreviation meant to
   stand for "kgdb over console".  Today it is the primary mechanism
   to configure how to communicate from gdb to kgdb as well as the
   devices you want to use to interact with the kdb shell.
   </para>

I've only tested kdb so far.

Anton
