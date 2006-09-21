Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 7F31567C11
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 19:38:49 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8LAwUQW012307 for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 04:58:30 -0600 (MDT)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8L9cj0q025317
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 04:38:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: what's the difference between portwidth & chipwidth
Date: Thu, 21 Sep 2006 17:38:44 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516C075@zch01exm21.fsl.freescale.net>
In-Reply-To: <004c01c6dd60$f4fa4880$a309a8c0@enorm>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "enorm" <enorm@126.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> what's the difference between portwidth & chipwidth in file=20
> cif_flash.c?=20

Assuming the system has 4 flash chips, and each flash chip is 16 bits =
witdh.
So, the portwidth is 64bits, that is 4 *16. the chipwidth is 16bits.

> what does "8M =D7 8 BITS" mean?
Looks up some flash datasheet, you will perfect know what is the =
meaning.

-Dave
