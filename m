From: Ruedi.Hofer@ascom.ch
Date: Thu, 27 Apr 2000 14:11:43 +0100 (CED)
Subject: MPC860T
To: linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0FTO0083YCJPTE@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_OazTPKJuACiGMnblXA8B/g)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_OazTPKJuACiGMnblXA8B/g)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

After some success with the native 860, I moved now to the 860T
on the FADS evaluation board.

With this test setup, I'd like to do some internetworking tests.
(like routing ...)

For that reason I need the FEC working as well as the SCC1 enet.

Facts:

1. The SCC1 enet compiles and runs ok on its own.

2. I'm not able to compile the kernel with only FEC enabled.
 (commproc.h reports: #error, undefined config!)

3. Is it possible to use SCC1 enet and FEC simultaneously.
 (fec.c has a comment like:
 If using multiple enets on 8xx, this needs some work!)

Has someone already done this work??

Can someone provide patches or howto's?

Thanx, Ruedi


--Boundary_(ID_OazTPKJuACiGMnblXA8B/g)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
