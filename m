Date: Wed, 10 May 2000 10:53:52 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Bernhard Reiter <bernhard@intevation.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
In-Reply-To: <20000510192813.B2162@cheops.usf.Uni-Osnabrueck.DE>
Message-ID: <Pine.LNX.3.96.1000510104735.21621B-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 10 May 2000, Bernhard Reiter wrote:

> When I had only 64MB the system was stable!
> I managed to compile GRASS (which is among the biggest free software
> projects) and other things.
>
> Plugging in a different 128MB and a different 64MB, both in the first
> slot, made the system unstable each time.

So it worked with your original 64 megs, but it fails with a different 64
meg part and a 128 meg part?  I don't see how that can be anything but bad
hardware, either something wrong with the motherboard or a pair of bad
SIMM/DIMM parts or dirty contacts or incorrectly seated RAM.

Had the strangest thing the other day... 8100 clone wouldn't boot up.  I
figured the PRAM battery was dead, so bought a new one and swapped it, no
luck.  Started pulling nubus cards, etc.  Had it all down to the mobo and
nothing.  Yanked the RAM and it came back up.  Reseated the RAM, and it
has been fine since.  :-/  Weird....


> As about the power consumption and the heat: It is my understanding that
> the fan should start up when there is too much heat controlled by
> hardware. But the fan does not start. And freezes also occur when the
> machine itself it cold. I also do not quite understand how the power
> consumption could be a problem here.

Me either.  I think the fan is started automagically in hardware anyway.
At least I'm pretty sure it was on the wallstreet....


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
