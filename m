Message-Id: <200109201935.PAA27446@makai.watson.ibm.com>
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers) 
In-Reply-To: Message from Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
   of "20 Sep 2001 21:29:39 +0200." <8xlmj9psnw.fsf@s62.informatik.uni-bremen.de>
Date: Thu, 20 Sep 2001 15:35:36 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Holger Bettag writes:

Holger> You are aware that a PPC in little endian mode is merely tricking with the
Holger> low order address bits, but does not actually lay out its data in a little
Holger> endian fashion in physical memory?

	This is why Mark said "assume I am also aware of the limiations of
the chip in LE mode and the intended target is 7400+ processors".
Motorola has added a more complete LE mode.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
