From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again... 
Date: Mon, 7 Aug 2000 15:18:42 +0200
Message-Id: <20000807131842.21074@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10008071127140.9070-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10008071127140.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Can anybody with a Macintosh SMP G4 confirm that the time bases are
>synchronized at boot ?

AFAIK, on those machines, I think Apple uses their "timer" device in the
new version of the mac-io ASIC to sync. timebases.

Reading Apple's CPU startup code in Darwin is _very_ interesting in fact.
That's for example how I learned that the only way to correctly and
completely flush the cache is to either reserve CPU-specific regions of
memory, use the ROM, or have external HW assist. Without that, any
snooping on the bus will garbage the flush process.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
