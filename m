Message-Id: <sccec3dd.067@mail.pel.dk>
Date: Tue, 30 Apr 2002 16:18:32 +0200
From: "Jakob Jepsen" <JSJ@voxtream.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Strange writings at 0x0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

When tracking a bug in our own code we stumbled over some strange
writings to addr 0x0.

The pattern :

00000000 : 55 00 30 55 01 30 5e 80 00 00 00 00 00 00 00 00

are written continuously to memory.

The writings have in them self no effect, but must be considered a bad
sign.

We are running on a MPC857T rev. A BETA running at 50 MHZ.
Linux version 2.4.4 from Denx

Have anybody seen something like this or have anybody an idea to where
the data are
coming from. (The CPM is a sure guess, but what are generating it ?)

Thanks.


Jakob

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
