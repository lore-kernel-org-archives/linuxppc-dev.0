Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Init hangs
Date: Fri, 6 Aug 2004 08:26:21 +0200
References: <20040805174857.A42F4C109F@atlas.denx.de>
In-Reply-To: <20040805174857.A42F4C109F@atlas.denx.de>
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408060826.21301.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,

> The fragmentation is OK, but this is not what you're looking for.

Ok.

> You should see a couple of LOOKUP calls, probably in the sequence  of
> /dev, console, sbin, init, lib, ld.so.1, and so on. Find out what the
> last succesful lookup call was, and what happens after this.

Searching the outputfile of ethereal tells me that the last working nfs LOOKUP call is the libc-2.3.1 call. After this and a lot of Read Call, Read Reply transfers the Target doesn't answer the host.
(ARP  "who has targetip-address?"). Before this, the ld.so.preload LOOKUP call fails.
(History: dev, console, sbin, init, lib, ld.so.1, ld-2.3.1.so, etc, ld.so.preload (fails), ld.so.cache, libc.so.6, libc-2.3.1, than it crashes). Is the ld.so.preload necessary?


Best regards
Marco


--
---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
