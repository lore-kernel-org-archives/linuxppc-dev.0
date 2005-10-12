Return-Path: <roffermanns@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 3BFAA684C7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 02:20:48 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 935C4FB862
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 17:47:39 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 7CE23FB862
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 17:47:39 +0200 (CEST)
Received: from kolab.sysgo.com (rof.sysgo.com [172.22.10.10])
	by donald.sysgo.com (Postfix) with ESMTP id 1A46B1ABDAF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 17:47:37 +0200 (CEST)
From: Rolf Offermanns <roffermanns@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 12 Oct 2005 17:47:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200510121747.38983.roffermanns@sysgo.com>
Subject: SPI driver for AMCC 440EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!
Does anyone have an SPI driver for the PPC440EP?

If not I am going to write one. In that case, what API would you suggest to 
use.

I checked the archives (both LKML and linuxppc-embedded) for SPI API 
discussions, but I am still not sure which way to go since all discussions 
ended at some point without an agreement. I would like to see the driver 
going into mainline someday, so please give me a hint about which way to 
choose.

Thanks,
Rolf
-- 
Rolf Offermanns <roffermanns@sysgo.com>
SYSGO AG     Tel.: +49-6136-9948-0
Am Pfaffenstein 14   Fax: +49-6136-9948-10
55270 Klein-Winternheim  http://www.sysgo.com
