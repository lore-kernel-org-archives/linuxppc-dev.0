Message-ID: <39A25B16.4A3DD5BC@uncc.edu>
Date: Tue, 22 Aug 2000 06:51:02 -0400
From: "William H. Schultz" <whschult@uncc.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
References: <200008160459.XAA20764@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For all of you saying that controlfb is broken...  I rsynced the
bitkeeper tree a few days ago, got it to compile, booted, etc...
however:  I have a voodoo3 card, and it is set as my main display.  The
voodoo3 was ignored, and the video went straight to the built in
controlfb on my 8500.  It worked just fine, and it worked the best it's
worked in quite some time.  I had no video artifacts at all, and
everything worked...  nice and smooth...  etc....  etc...

But the only way for me to use the voodoo3 (which is the card supporting
my BIG monitor) is to completely disable the video drivers from Boot
X...  odd quirk...

but now...  the bitkeeper tree doesn't compile again...  can't find
adbhid.o...  another story...



Hank

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
