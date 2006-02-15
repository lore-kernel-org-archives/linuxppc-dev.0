Return-Path: <dibacco@inwind.it>
Received: from smtp20.libero.it (smtp20.libero.it [193.70.192.147])
	by ozlabs.org (Postfix) with ESMTP id 05F44679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 08:41:17 +1100 (EST)
Received: from localhost (172.16.1.246) by smtp20.libero.it (7.0.027-DD01)
	id 43E0E9160133AAB0 for linuxppc-embedded@ozlabs.org;
	Wed, 15 Feb 2006 22:41:14 +0100
Received: from smtp20.libero.it ([172.16.1.76])
	by localhost (asav14.libero.it [193.70.193.42]) (amavisd-new,
	port 10024)
	with ESMTP id 24350-21 for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 22:41:14 +0100 (CET)
Received: from libero.it (172.16.1.239) by smtp20.libero.it (7.0.027-DD01)
	id 431C3BFF01A89327 for linuxppc-embedded@ozlabs.org;
	Wed, 15 Feb 2006 22:41:14 +0100
Date: Wed, 15 Feb 2006 22:41:14 +0100
Message-Id: <IUR08Q$EA50D33FB87244406C6EB74722F8E71C@libero.it>
Subject: IMAP_ADDR is virtual or physical address?
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

I'm wondering if IMAP_ADDR is a virtual address or a physical one. Normal=
ly I see things like this in drivers:

static volatile immap_t *immr =3D (immap_t *) IMAP_ADDR;

It seems therefore a virtual address.

But I can see the same also in some u-boot code where I imagine we are ac=
cessing physical addresses.

Clear my doubt please!!

Bye,
