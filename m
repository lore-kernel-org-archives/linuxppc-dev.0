Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0A50@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'nebuphilips@eudoramail.com'" <nebuphilips@eudoramail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: 64-bit Data Flash Access Problem [MPC8245]
Date: Wed, 24 Sep 2003 13:31:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Are you sure you are not using software floating points?

-----Original Message-----
From: Augustine Nebu Philips [mailto:nebuphilips@eudoramail.com]
Sent: Wednesday, September 24, 2003 1:05 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: 64-bit Data Flash Access Problem [MPC8245]



Hi
I have a set of 8 1GB data flash chips (Samsung) on an MPC8245 Ref. Board.
These are on a 64-bit bus-mode.

-------DBUS_SIZ[0-1]:DBUS_SIZ[2] = 110b -------

All 8 chips are selected by a single chip select (RCS1). Trying a 32-bit
read from the Data Address Location after giving the Command to Access the
flash IDs, only 4 flashes on a common byte lane seem to be responding.
32-bit writes appear only on the DH[0-31] and not on DL[0-31].

I am not very clear as to:

(a) How do we perform writes to send out data out on
    all 64-bits of the bus..?
(b) How would we ideally access 64-bit data through 32-    bit reads..?
(c) Or must we *have* 64- bit read/write
    instructions..?

many thanks in advance for any response ..

Regards
Nebu


Need a new email address that people can remember
Check out the new EudoraMail at
http://www.eudoramail.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
