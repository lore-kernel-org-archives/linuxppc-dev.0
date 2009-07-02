Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1F6D5B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 02:12:13 +1000 (EST)
Received: from exprod5og103.obsmtp.com (exprod5og103.obsmtp.com [64.18.0.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A39D0DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 02:12:11 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 0/5] Generic NVRAM support for large MMIO devices
To: linuxppc-dev@ozlabs.org
Date: Thu, 02 Jul 2009 17:12:12 +0100
Message-ID: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series allows the generic NVRAM driver to access MMIO based NVRAMs. In addition it enables support for NVRAMs of sizes differing from those found on PowerPC Macs (providing a safe fallback). Patches are also included to enable support for the NVRAM found on the GE Fanuc PPC9A, SBC310 and SBC610.

If this patch series is unsuitable this late in the day for 2.6.31, please concider it for 2.6.32.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
