Date: Tue, 17 Jul 2001 13:35:28 -0500 (EST)
From: Paul Harrison <pfh@csse.monash.edu.au>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Turning on sound in the new iBook
Message-ID: <Pine.LNX.4.33.0107171325290.754-100000@mandarin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A few people have asked me about this, so i thought i would post it here:
I have sound working on the new iBook, mostly from looking at the Darwin
source.

The basic steps were:
- powering up the sound system and one of the amps by writing to some
ports
- setting up the digital equalizer using I2C
- using the dmasound_pmac module for actual sound output

Full details here:

http://yoyo.cc.monash.edu.au/~pfh/ibook/sound.html

This is all really, really hacked together. It should all probably be put
together in one or two nice neat kernel modules at some stage.

--
Paul Harrison

Email: pfh@csse.monash.edu.au
Web:   http://yoyo.cc.monash.edu.au/~pfh/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
