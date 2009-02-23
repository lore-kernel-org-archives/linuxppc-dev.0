Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6b.your-server.co.za [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C81CDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 20:23:25 +1100 (EST)
Received: from [196.213.226.33] (helo=[172.16.63.116])
	by www6.jnb1.host-h.net with esmtpa (Exim 4.66)
	(envelope-from <phenning@vastech.co.za>) id 1LbX1w-0001lx-3J
	for linuxppc-dev@ozlabs.org; Mon, 23 Feb 2009 11:23:16 +0200
Message-ID: <49A26B03.4080300@vastech.co.za>
Date: Mon, 23 Feb 2009 11:23:15 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Custom kernel driver for MPC8548
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms010509030004080901090902"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a cryptographically signed message in MIME format.

--------------ms010509030004080901090902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all

I recently ported my board to use the new U-boot 2009 and boot Linux
2.6.27. ( the previous Linux version was 2.6.19 which supported the ppc
architecture)

I am now at the stage where I need to port a custom platform driver. The
driver used files that resided in /include/asm-ppc/. which are no longer
available using the powerpc architecture. Can someone please guide me as
to where to look for the appropriate contents?

In particular:
asm-ppc/io.h
asm-ppc/mpc85xx.h
asm-ppc/immap_85xx.h

thanks Pieter

--------------ms010509030004080901090902
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
i/9p39yr0xJVGta/xOf1xgAAAAAAAA==
--------------ms010509030004080901090902--
