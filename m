Message-ID: <3B871315.1CA43487@mvista.com>
Date: Fri, 24 Aug 2001 22:53:09 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
References: <3B85E0D2.21BC306E@mvista.com> <20010824102831.14636@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> We should even be able to not flush all the cache here but only
> the possible "synonyms" as we know the real address.

Right.  We can do some of this due to the recent MM rework by Paulus.
I know the complete flush will work, and once we get the kernel
running again we can fine tune the synonym search.  We have to be
careful about some of these complex functions to do these operations,
they could very well run mode code and do more hard to the cache
that just flushing it and getting on with life :-).

> It still doesn't work :(

Hang on, we'll get it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
