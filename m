Message-ID: <3B708C81.DE87DDC2@iiic.ethz.ch>
Date: Wed, 08 Aug 2001 02:49:05 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Reply-To: daenzer@debian.org
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: R Shapiro <reshapiro@mediaone.net>, Olaf Hering <olh@suse.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: lcd17 kernel patches?
References: <Pine.LNX.4.05.10108070947420.5836-100000@callisto.of.borg>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Mon, 6 Aug 2001, Michel Dänzer wrote:
> > R Shapiro wrote:
> > > Olaf Hering writes:
> > >  > The correct fix is either "video=1280x1024-8@60" as kernel arg (that
> > >  > may work)
> > >
> > > OK, I just had time to rebuild 2.4.8-pre3-ben0 with the patch undone.
> > > This video arg with that kernel doesn't solve the problem.  I still
> > > get no video on boot.
> >
> > Wouldn't it have to be video=aty128fb:1280x1024-8@60 anyway, and is the
> > modedb
>
> video=mode specifies the global mode, for all fbdevs that use modedb.

Ah, cool. So what's your theory on why it didn't work for R?


> > even used on PPC yet?
>
> That's not the right question :-) Modedb doesn't depend on the architecture,
> but on the driver.

I meant to say 'in aty128fb on PPC'. Last time I looked, the call to find a
mode was disabled for PPC.

> Yes, atyfb was the first one to have modedb. Remember, I have a RAGE II+ in
> my LongTrail :-)

Didn't mean to question that.

> PowerMac/CHRP has even extra modedb support in macmodes.

Would that explain the disabled direct call?


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
