Message-ID: <396C863F.1E6285A6@embeddededge.com>
Date: Wed, 12 Jul 2000 10:52:47 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-t1 & t3: dmasound
References: <200007121106.MAA13142@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> has anyone got dmasound_awacs to produce output under test1-ac21 or test3?

I am using test2-ac18 on my G4 server (workstation :-).  It works
fine there.  I haven't tried -test3 yet because of all of the other
bugs we are fixing.

By the way, I have some 48Khz modifications.  Basically the inverse
of the expand functions.  Anyone else doing this or attempting 48Khz
playback?  Obviously record only works at 44.1Khz.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
