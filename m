Message-ID: <FC3C0DD86B79DF4FA423AF0379A5476101554372@mailguy2.nuvation.com>
From: Oliver King-Smith <oliver.king-smith@nuvation.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem trying to address custom hardware
Date: Wed, 25 Aug 2004 15:29:20 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Things are working much better.  Both the driver and the main code work
without crashing now.

> Others addressed your core problem, but you should know that this
> mmap request won't produce the desired result. You need MAP_SHARED
> since MAP_PRIVATE will result in a COW when you attempt to modify
> your register.

I am not sure I understand why this needs to be MAP_SHARED (it sure does
though).  Is there a good resource I can read to understand this a bit
better?

Oliver


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
