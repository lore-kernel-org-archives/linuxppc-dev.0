Message-ID: <3B83B46C.8030805@cray.com>
Date: Wed, 22 Aug 2001 08:32:28 -0500
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Physically mapped FLASH
References: <EFEAIMDCOOOHIEPHDNFJAEHDDBAA.stefan.roese@esd-electronics.com> <20010822134155.4105@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

Is there a reason why the physical-mapping setup (drivers/mtd/maps/physmap.c)
is coded to ONLY talk to CFI chips?  For example I have some 405gp things
that have AMD Flash chips that are physically mapped to the top of memory
and could be driven by the algorithms in drivers/mtd/chips/amd_flash.c.

I've patched it and it appears to work ok; is it a bad idea?  is it good idea?
Any interest in incorporating in?

--
Dave Updegraff / dave@cray.com / 218-525-1154


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
