Date: Sun, 9 Jul 2000 22:29:54 +1200
From: Gwyn Judd <b.judd@xtra.co.nz>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: X still locks up
Message-ID: <20000709222954.A1240@thislove.dyndns.org>
References: <200007090058.BAA22277@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200007090058.BAA22277@hyperion.valhalla.net>; from iain@sandoe.co.uk on Sun, Jul 09, 2000 at 01:58:42AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 09, 2000 at 01:58:42AM +0100, Iain Sandoe wrote:
>
> > On Sat, Jul 08, 2000 at 11:06:40PM +0100, Iain Sandoe wrote:
> >> Three things:
> >>
> >> 1/ did you try the backported audio stuff I posted yesterday - there were
> >> some issues that were resolved between 2.2.xx and 2.3/4.xx these should be
> >> present in the backport.  It does work OK against 2.2.17pre10-ben1.
> >
> > Oh whoops can you send that to me or tell me where I can get it? I
> > thought it was part of bens kernel.
>
> Well, I wish it might be one day - but it's quite new (yesterday) and it
> will take a bit more testing before it's accepted.
>
> here's the URL:
>
> http://quimby.gnus.org/circus/dmasound_backport.patch.bz2
>
> (but there's no reference to it anywhere higher up so use something like
> anarchie/interarchy get via http - or whatever).

Okay I tried that one by applying the patch to the current stable kernel
(2.2.17 I believe). Once gnome started up I got an error message "No
mixers found". When I tried to play an mp3 through xmms X locked up
completely although I was able to change VT's, however I was unable to
kill X or reboot properly. Oh well at least fsck is getting a work-out
this week :).

I'm going back to 2.2.14 for a bit to see if I get the same problem with
a slightly older kernel.

--
Gwyn Judd (b.judd@xtra.co.nz)
I hate quotations.

		-- Ralph Waldo Emerson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
