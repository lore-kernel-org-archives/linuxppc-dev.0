Message-ID: <67505026E29DD311A9AA00508B7315F350A603@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: scc2 using brg4 in uart.c
Date: Tue, 12 Dec 2000 17:36:54 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


		Hello,
		I have changed scc2 in uart.c to support brg4 instead of
brg1

		I enabled txd2, rxd2, disabled rts2, enabled cd 2

		Cp->cp_sicr &= ~0x0000ff00;
		Cp->cp_sicr |= ~0x00002600;

		I checked to see that the write buffer is storing characters
and calling memcpy to output to the current buffer descriptor with an
appropriate amount of data, but then nothing happens.....
		I am not getting any interrupts on SCC2. I am still using
SMC1 for my console.
		Any great minds want to offer any clues as to why I would
not get interrupts on SCC2?

		Thank you in advance,
		Julia


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
