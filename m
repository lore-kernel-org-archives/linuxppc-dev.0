Message-ID: <3CFB7595.AF86DFF0@ssh.com>
Date: Mon, 03 Jun 2002 16:56:37 +0300
From: Arto Vuori <avuori@ssh.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 IDMA experience?
References: <NCBBIINEHIPFGJPLBEIFOEAFDIAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:
> So it works but it may not be as fast as a memcpy(). Sounds like more
> testing is required to determine the overall benefit of freeing the
> processor.

Right. We are using IDMA only for accessing slow devices, so that CPU
don't need to wait for the data and can do some usefull work
simultaneously.

>
> > I did also notice that when i am doing memory-to-peripheral (or
> > vice-versa) transfers, IDMA corrupts simultaneous Ethernet traffic
> > unless IDMA is set to low-priority mode. Same might apply for
> > memory-to-memory transfers.
>
> What 8260 chip revision are you using? I have found lots of problems when
> rev A processors but rev C has been much better.

I have done most of my testing with revision A chips. I've had many
problems with those chips and it took some time with logic analyzer to
debug those IDMA transfers before i got them working.

Arto

--
Arto Vuori
email: avuori@ssh.com
mobile:	+358 40 754 5223

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
