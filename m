Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C85B@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: 4 bit LCD interface on 823e not working
Date: Mon, 26 Aug 2002 21:12:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As you probably can guess I'm trying to get this Optrex display working.
Well I've finally scoped it out, and I can't find the cause (or solution to)
my problems.

When I write the following nibbles for display, I get these bit patterns out
of the pins and on screen:
0: 1111
1: 1010
2: 0111
4: 0100
5: 1011
8: 0100
A: 0110
F: 1101

There seems to be no rhyme or reason, at least I don't have a clue. The bits
are all clocked in parallel, 4 at a time. Can any please help?
I'm digging in the 823e book for any registers that may need to be changed.
-Jason

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
