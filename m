Message-ID: <3D0D89E6.6040704@esd-electronics.com>
Date: Mon, 17 Jun 2002 09:04:06 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: Dan Brennan <dmb8@optonline.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: compact flash and true IDE mode
References: <3D0A3DA4.586D0956@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

take a look into the CPCI405 target support in the recent devel tree.
We use a mem'mapped CF card as storage device on many of our boards.

The file linux/drivers/ide/cpci405.c should be a good starting point for your work.

Matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
