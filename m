From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <christopher.murtagh@wcg.mcgill.ca>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mmu_context_overflow
Date: Fri, 16 Feb 2001 09:28:39 +0100
Message-Id: <19350111020023.29855@smtp.wanadoo.fr>
In-Reply-To: 
 <Pine.LNX.4.21.0102160021250.5346-100000@saraswati.wcg.mcgill.ca>
References: <Pine.LNX.4.21.0102160021250.5346-100000@saraswati.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I usually get 3 of these a day, sometimes 2, sometimes 4, mostly they
>coincide with really high traffic periods (150k http request per hour -
>this server is 99% http traffic), but I have had some at what seem to be
>low traffic periods (but this is rare).
>
> I haven't seen this on any of our other G4s, but none of them are taking
>on anywhere near that amount of traffic. Do you suspect it might be a
>hardware problem with this particular machine?

Well, it's possible that it's an HW bug. I also suspect a software bug
that was fixed, but AFAIK, 1.3 is ok. If the driver manages to reset the
PHY and continue to operate properly, then things are nice. I'll still,
on my side, check for possible race conditions in the ring Tx code when
load is really high.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
