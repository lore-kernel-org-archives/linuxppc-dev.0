Message-ID: <3BBB35A2.C2708418@mvista.com>
Date: Wed, 03 Oct 2001 11:58:26 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Nguyen Trung Thanh <jaringuyentrungthanh@yahoo.com>
Cc: "'Linuxppc-Embedded '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: USB Isochronous for MPC823
References: <619D608DD3F0D311882C009027732E1A8B1779@ntserver.act.domain> <004001c14bf3$7c326c60$b480a984@int.serialsystem.com.sg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nguyen Trung Thanh wrote:

> I've tried to use m8xxhci.c from Hardhat2.0,
> but I saw that it still has a bunch of errors.

The USB on 8xx isn't going to work properly without the
proper chip revision, matching microcode patch, and specific
board modification (8xx pin loopbacks).  Have you read the
Motorola errata, USB application notes, and properly followed
those?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
