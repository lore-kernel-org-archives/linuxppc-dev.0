Date: Mon, 5 Feb 2001 20:28:21 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Robert E Brose II <bob@kunk.jriver.com>
cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in
In-Reply-To: <20010205023918.21795.qmail@kunk.jriver.com>
Message-ID: <Pine.LNX.4.30.0102051934180.18886-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Thanks Daniel for digging this stuff out. A fix for the 53c94
> disconnect problem would sure make the 7200 a  better platform.

Unless Paul had specific reasons not to use the generic NCR53C9x driver
code for the mac53c94 driver, I'd say we should start from scratch using
the generic driver code base. I know it looks messy and a lot of the Sparc
cruft should be stripped out (IIRC Sparc still uses esp.c) but it might be
worth the trouble.

Problem is, the only Powermacs I could use for testing are a 7100 and a G3
(233 MHz desktop). Which one of these does use the 53C94?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
