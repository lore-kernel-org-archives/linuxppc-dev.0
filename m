From: "Bill Royal" <bill@spicetech.com>
To: "Claude Robitaille" <root@videotron.ca>, "Dan Malek" <dmalek@jlc.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: fadsrom
Date: Sun, 25 Jul 1999 05:31:41 -0400
Message-ID: <NCBBKCLAOLHFIOJGGGALCEFLCCAA.bill@spicetech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.10.9907241634440.2090-100000@modemcable220.93-200-24.mtl.mc.videotron.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


claude,

start.s is in there; try opening fadsrom.tgz with something like WinZip on a
PC.  I'm no expert on compression formats, but we found that opening it with
'tar zxvf' didn't produce that file, but winzip95 extracted everything.
Maybe Dan added that file to the archive after it was created?

Bill

-----Original Message-----
From: owner-linuxppc-dev@lists.linuxppc.org
[mailto:owner-linuxppc-dev@lists.linuxppc.org]On Behalf Of Claude
Robitaille
Sent: Saturday, July 24, 1999 4:42 PM
To: Dan Malek
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: fadsrom



Dan,

Ok, I'll work on it; part time... so it may take a little
while..

Where is start.S? I searched on my whole system (thinking
it is a generic source, which probably does not make sense
but just in case). Anyway, I did not find it, all I found
is start.c in coffboot and chrpboot.

for bintos19.c; I downloaded from the same place as you. I just
did it again, gunzipped and did tar tf on it; no bintos19.c
or start.S. There is 19 files, is this ok? Do you untar in
an existing directory on your system where does files already
exists?

Claude


On Tue, 20 Jul 1999, Dan Malek wrote:

> Claude Robitaille wrote:
>
> > I want to use your fadsrom and I also want to modify it to
> > add s-record download (unless you or somebody else on the list
> > has already done it ...).
>
> Go for it!
>
>
> > The first thing is, obviously, to compile it as is; I fail ..... :-(
> > I am missing start.o. Where is it coming from?
>
> >From start.S.......
>
>
> > There is no
> > source in fadsrom.tgz (BTW I also notice that bintos19.c is
> > missing, this would be pretty handy ....)
>
> I don't know what you downloaded, but I just downloaded the
> file from ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/
> and everything was there.....

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
