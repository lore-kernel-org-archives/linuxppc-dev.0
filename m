Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1C0EDDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 22:42:37 +1000 (EST)
Received: from [85.211.60.224] (helo=sheep.housecafe.de)
	by mail.g-house.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1Hll6R-0001s5-EY
	for linuxppc-dev@ozlabs.org; Wed, 09 May 2007 14:17:07 +0200
Received: from localhost ([127.0.0.1] helo=derchris.gotdns.org)
	by sheep.housecafe.de with esmtp (Exim 4.67)
	(envelope-from <lists@nerdbynature.de>) id 1Hll6L-0002Fh-7K
	for linuxppc-dev@ozlabs.org; Wed, 09 May 2007 13:17:01 +0100
Message-ID: <41721.194.246.123.252.1178713021.squirrel@derchris.gotdns.org:8080>
Date: Wed, 9 May 2007 14:17:01 +0200 (CEST)
Subject: 2.6.21-git11: Section mismatch warnings
From: "Christian Kujau" <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Sender: "evil@g-house.de"@mail.g-house.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi there,

tracking -git for quite a while now, I've seen these warnings when trying
to compile 2.6.21-git11:

WARNING: arch/powerpc/kernel/built-in.o - Section mismatch: reference to
.init.data:.got2 from alloc_top_high (offset 0x158)

The whole buildlog and .config is here:
http://nerdbynature.de/bits/2.6.21-git11/

Eventually this results in:

WRAP    arch/powerpc/boot/zImage.coff
ld: arch/powerpc/boot/coff.o: No such file: No such file or directory
nm: 'arch/powerpc/boot/zImage.coff': No such file
objdump: 'arch/powerpc/boot/zImage.coff': No such file
  Building modules, stage 2.
  MODPOST 85 modules

arch/powerpc/boot/zImage however has been built, which I am using to boot
(I've not tested if -git11 boots OK).

Thanks,
Christian.
-- 
BOFH excuse #442:

Trojan horse ran out of hay
