Return-Path: <dibacco@inwind.it>
Received: from smtp4.libero.it (smtp4.libero.it [193.70.192.54])
	by ozlabs.org (Postfix) with ESMTP id 577E167B2A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 03:51:11 +1100 (EST)
Received: from localhost (172.16.1.202) by smtp4.libero.it (7.0.027-DD01)
	id 43E2149B00D54FE0 for linuxppc-embedded@ozlabs.org;
	Sat, 11 Feb 2006 17:51:09 +0100
Received: from smtp0.libero.it ([172.16.1.204])
	by localhost (asav16.libero.it [193.70.193.3]) (amavisd-new, port 10024)
	with ESMTP id 28000-18-4 for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 17:51:08 +0100 (CET)
Received: from libero.it (172.16.1.237) by smtp0.libero.it (7.0.027-DD01)
	id 439064B400B43E52 for linuxppc-embedded@ozlabs.org;
	Sat, 11 Feb 2006 17:51:08 +0100
Date: Sat, 11 Feb 2006 17:51:08 +0100
Message-Id: <IUJ858$C1F6D8106A36F0F6CCFEC4D03BD42B33@libero.it>
Subject: MBX AMD AM29F080 flash not recognized
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

on my MBX board I have two flashes: AM29F040 called bootrom and four chip=
s of AM29F080 (each one 8 Mbit for a total of 4MB).

The kernel (from DENX) doesn't find the AM29F080. I added the following i=
n amd_flash.c to support AM29F040 (a friend of mine told me)

#define AM29F040	0x00A4

and also:

{
                mfr_id: MANUFACTURER_AMD,
		dev_id: AM29F040,
		name: "AMD AMD29F040",
		size: 0x00080000,
		numeraseregions: 1,
		regions: {
	          { offset: 0x000000, erasesize: 0x10000, numblocks: 8 },
		}
},

in the amd_flash_info table.

For AM29F080 I don't know what to add and if to add something is ok !?!?!=
?!?

Someone knows?

Furthermore, how can I specify that there are 4 chips of AM29F080?

The kernel will handle this automatically?

Bye,
Antonio.
