Date: Sat, 24 Jul 1999 16:41:47 -0400 (EDT)
From: Claude Robitaille <root@videotron.ca>
To: Dan Malek <dmalek@jlc.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: fadsrom
In-Reply-To: <3793F953.68DFEF14@jlc.net>
Message-ID: <Pine.LNX.4.10.9907241634440.2090-100000@modemcable220.93-200-24.mtl.mc.videotron.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


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
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
