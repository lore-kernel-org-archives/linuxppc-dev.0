Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay006.isp.belgacom.be (mailrelay006.isp.belgacom.be
	[195.238.6.172]) by ozlabs.org (Postfix) with ESMTP id 2E237DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 21:30:43 +1000 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id D56AF3A91
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 13:30:38 +0200 (CEST)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id B890E3891
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 13:30:38 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Device tree compiler
Date: Mon, 17 Sep 2007 13:30:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709171330.37642.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

I'm trying to port a MPC8248-based board from ppc to powerpc.

While looking for example DTS files I found out that the Linux kernel sourc=
es=20
include a few of them in arch/powerpc/boot/dts. However, they don't compile=
=20
with the latest device-tree compiler available at=20
git://ozlabs.org/srv/projects/dtc/dtc.git.

One of the most common error comes from references to the PIC using a node=
=20
name instead of a linux,phandler value. As most DTS files in the kernel=20
sources fail to compile, I was wondering if there was another DTC I was not=
=20
aware of, or if those files have actually never been compiled.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
