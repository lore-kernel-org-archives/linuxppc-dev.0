Date: Tue, 27 Jan 2004 19:07:31 +0100 (CET)
From: Christian Kujau <evil@g-house.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc trees / BK help
In-Reply-To: <jewu7d2wdp.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0401271859140.15510@sheep.housecafe.de>
References: <40168C3E.7010903@g-house.de> <jewu7d2wdp.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Christian Kujau <evil@g-house.de> writes:
>
> > after passing the consistency check, a sourcetree shows up  but
> > filenames are different from normal:
> >
> > evil@sheep:/data/MP3/scratch/kernel$ ls linuxppc-2.5-benh-BK/
> > BitKeeper  Documentation  SCCS  arch  crypto  drivers  fs  include  init
> > ~ ipc  kernel  lib  mm  net  scripts  security  sound  usr
> > evil@sheep:/data/MP3/scratch/kernel$
> >
> > - --> there are no files in the directory, only dirs.
>
> $ bk -r get

wow, thanks for the quick reply! it works!
RTFM for me today...

Thank you,
Christian.

--
BOFH excuse #390:

Increased sunspot activity.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
