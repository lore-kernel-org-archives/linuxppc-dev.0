Date: Fri, 19 Jan 2001 10:04:41 +0000
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010119100317.203BE2EFC8@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I believe there is a danger we are missing the point of ed21 of the driver.

1/ the main point... is that I believe the dbdma stuff is now working
reliably - which should make record functional and playback robust.

2/ In fact - the driver has, for some time, been compliant (AFAICT) with OSS
Progammer's Guide 1.1 (June 2000).  So, I suppose that I could just say "if
the app gives noise - it's broken".

If anyone believes that there is an error in this compliance - I'll be happy
to try & fix it or help someone else do so.

3/ The "pismo LE fix" is a small part and quite easily backed out of/left in
as people like.  It is no more/less "correct" to include it in the driver
than some of the other stuff that's already there.

4/ The driver offers (in the official, released version) a number of
non-native formats as valid input.  I do not believe it is "strictly
necessary" under OSS rules to do this.

-----

otherwise, I agree with you on the principles (not putting stuff in the
kernel that belongs in user space).

I would find it just as wasteful as you to swap data twice - for 'real'
(a.k.a. paid) work I write a fair bit of real time dsp code...

... but I don't think I had better comment further on stuff which is mostly
reported to me rather than tested (personally) by me.  It is, of course,
possible that people are reporting errors with old versions of apps - but
this path is usually checked in discussion of reported "format bugs" in the
driver.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
