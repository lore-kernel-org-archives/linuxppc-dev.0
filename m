Message-ID: <3D1A2BD9.5090004@bluewin.ch>
Date: Wed, 26 Jun 2002 23:02:17 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Chuck Partridge <Chuck_Partridge@amx.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: AMD Flash Interface for updating boot flash
References: <sd19dc75.088@mx.amx.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 06/26/2002 10:23 PM, Chuck Partridge wrote:

>Where do you set this up? If I want to use partitions, where do I put the info on how it is partitioned?
>
>I modified the kernel .config and it gives me the following startup messages:
>
>physmap flash device: 80000 at fff00000
>CFI: Found no Physically mapped flash device at location zero
>
>I'll check out the MTD list.
>
>Chuck
>
Have a look to

  http://www.denx.de/doc/TQM8xxL/advanced-topics.html#FLASH-FILESYSTEMS

That's the way it is done for TQM8xxL. Maybe you just need to setup a
mapping
for your board in drivers/mtd/maps.

Hope it helps,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
