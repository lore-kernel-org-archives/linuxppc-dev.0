Message-Id: <sd199301.035@mx.amx.com>
Date: Wed, 26 Jun 2002 10:09:37 -0500
From: "Chuck Partridge" <Chuck_Partridge@amx.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: AMD Flash Interface for updating boot flash
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I have been searching the archives and I am a bit confused, so bear with me if this is too simple a question.

I need to provide a way to update my boot flash from user space.
Our user application will download an boot flash image and save it (to a file or a buffer), we must then write the flash.
I have seen references in the archives to Denx's drivers/char/amd_flash.c and to MTD drivers, or I can
implement my own driver, but I'm not sure of the best (i.e. easiest and cleanest) way.

I don't need to put a file system on the flash.  All it does is hold the PPCBoot image.  The flash part is an AMD
29LV004B and is setup for 8 bit interface.  I am running a 2.4.17 kernel on an 8245.

Any suggestions?

Thanks,

Chuck


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
