Date: Tue, 19 Nov 2002 15:33:47 -0500
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Unexpected sleep on old iBook
Message-ID: <20021119203347.GK8575@paco.resnet.purdue.edu>
References: <2C5637A6A7CE844EA3C0A94565479F5275A2E2@dest-as20-002.int.bauer-partner.com> <Pine.LNX.4.33.0211191743560.11419-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0211191743560.11419-100000@opal.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz spake unto us the following wisdom:
> Please try running pmud with the -s or -S flag (signal init on power low)
> and take note of the battery power level readings. I suspect the kernel
> does return erroneous power readings on occasion, causing pmud to trigger
> sleep. I've not been able to reproduce this on my Lombard Powerbook -
> other users (iBook IIRC) report the battery power suddenly dropping to
> zero from as much as 80%. I'm currently trying to collect more information
> on this new feature.

I have a first generation iceBook (500MHz/64MB stock/Rage128
Mobility), and I never see this behavior ... however, I recently
talked my girlfriend into a new iceBook, and the model she got
(600MHz/128MB stock/Radeon Mobility M6 LY) does.  It doesn't seem to
be predictable as best we can tell, and it doesn't happen often.  It
seems to happen whether the laptop is plugged into wall power or not.

(Does it irritate anyone else that there seems to be no *good* way to
 differentiate iBook versions?  I'm sure there's some motherboard
 resource version that's unambiguous, but come on...)

If I can provide any information that might be useful, please let me
know.  I have both of these laptops sitting in the same room with me
pretty much every day of the world for at least some period of time.

Ethan

--
And if I claim to be a wise man / it surely means that I don't know.
                -- Kansas, "Carry on Wayward Son"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
