To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 24 Sep 2003 12:34:38 -0500
From: "Augustine Nebu Philips" <nebuphilips@eudoramail.com>
Message-ID: <JGEKGDBLHJDFGFAA@whowhere.com>
Mime-Version: 1.0
Reply-To: nebuphilips@eudoramail.com
Subject: RE: 64-bit Data Flash Access Problem [MPC8245]
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve,
 I tried to use fp assembly instructions (like lfd). But my assembler has problems and doesnt let me generate my binary. I'm sorry I couldnt properly get you... Should I make use of sw floating points..? That means, should I access 64-bit data only through 64-bit operations..?

Thanks and Regards
Nebu
--------- Original Message ---------

DATE: Wed, 24 Sep 2003 13:31:50
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>

>Are you sure you are not using software floating points?
>

>Subject: 64-bit Data Flash Access Problem [MPC8245]
>
>
>
>Hi
>I have a set of 8 1GB data flash chips (Samsung) on an MPC8245 Ref. Board.
>These are on a 64-bit bus-mode.
>
>-------DBUS_SIZ[0-1]:DBUS_SIZ[2] = 110b -------
>
>All 8 chips are selected by a single chip select (RCS1). Trying a 32-bit
>read from the Data Address Location after giving the Command to Access the
>flash IDs, only 4 flashes on a common byte lane seem to be responding.
>32-bit writes appear only on the DH[0-31] and not on DL[0-31].
>
>I am not very clear as to:
>
>(a) How do we perform writes to send out data out on
>    all 64-bits of the bus..?
>(b) How would we ideally access 64-bit data through 32-    bit reads..?
>(c) Or must we *have* 64- bit read/write
>    instructions..?
>
>many thanks in advance for any response ..
>
>Regards
>Nebu
>
>
>Need a new email address that people can remember
>Check out the new EudoraMail at
>http://www.eudoramail.com
>
>



Need a new email address that people can remember
Check out the new EudoraMail at
http://www.eudoramail.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
