Message-Id: <200009011135.MAA00397@hyperion.valhalla.net>
Date: Fri, 01 Sep 2000 12:35:37 +0100
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        "Timothy A. Seufert" <tas@mindspring.com>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>2. During the fb probe of the Rage 128 PCI card, a pattern of colored
>>characters is written to the screen.  This might be somebody's
>>deliberate debug output, as it almost looks too regular to be an
>>error.
>
> I noticed that too. It happens only occasionally. Sometimes, it's so bad
> that I never get a single correct char displayed, sometimes it just
> doesn't happen. Note that I didn't have the problem for a week or two
> now, I thought it was fixed. Sounds a bit like someone is corrupting memory...

Not just rage 128 (perhaps - I can't tell 100%) but this also happens (it's
come & go with different -testxx ) on my G3-beige [if you mean patterns that
are squares with different coloured dots in the centre]  I was *sure* it was
deliberate debug...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
