Date: Tue, 7 Aug 2001 11:00:37 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
Message-ID: <20010807110037.A15097@suse.de>
References: <3B6E8B6E.BED87E1A@iogram.ch> <Pine.LNX.4.05.10108070947420.5836-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.05.10108070947420.5836-100000@callisto.of.borg>; from geert@linux-m68k.org on Tue, Aug 07, 2001 at 09:49:38AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 07, Geert Uytterhoeven wrote:

> On Mon, 6 Aug 2001, Michel Dänzer wrote:
> > R Shapiro wrote:
> > > Olaf Hering writes:
> > >  > The correct fix is either "video=1280x1024-8@60" as kernel arg (that may
> > >  > work)
> > >
> > > OK, I just had time to rebuild 2.4.8-pre3-ben0 with the patch undone.
> > > This video arg with that kernel doesn't solve the problem.  I still
> > > get no video on boot.
> >
> > Wouldn't it have to be video=aty128fb:1280x1024-8@60 anyway, and is the modedb
>
> video=mode specifies the global mode, for all fbdevs that use modedb.

You mean video=1280x1024-8@60 is supposed to work? I think that syntax
makes much more sense than video=aty128fb:1280x1024-8@60 when you have
only one card or when only one fbdriver is active.



Gruss Olaf


--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
