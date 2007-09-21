Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 28B0EDDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 18:53:08 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by comm-neu.esd (Postfix) with ESMTP id 0122D108048
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 10:46:16 +0200 (CEST)
Received: from comm-neu.esd ([127.0.0.1])
	by localhost (comm [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 28419-03-6 for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 10:46:14 +0200 (CEST)
Received: from debby.esd (debby.esd [10.0.0.190])
	by comm-neu.esd (Postfix) with ESMTP id ED971108046
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 10:46:14 +0200 (CEST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: ioremap with cache on 44x
Date: Fri, 21 Sep 2007 10:46:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200709211046.11253.matthias.fuchs@esd-electronics.com>
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

I want to ioremap some memory on a PCI board with caching from a 440EPx
CPU. Typically ioremap() ends in __ioremap() with the flags set to _PAGE_NO_CACHE.
But even without this flag, the remapped range does not use the cache.
Using a BDI2000 debugger I always see the corresponding TLBs with 
caching inhibited.

How can I access PCI memory with caching?

Matthias
