Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by ozlabs.org (Postfix) with ESMTP id EBB36DDEF5
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:11:05 +1000 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 2813A3AEE
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 10:11:01 +0200 (CEST)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 0A9BA3A1E
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 10:11:01 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: What's the preferred way to export board information to userspace ?
MIME-Version: 1.0
Date: Tue, 2 Oct 2007 10:10:59 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710021011.00224.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,

it seems linuxppc-embedded is going away. I should have posted this here in=
=20
the first place, so sorry for the cross-post.

I need to export some read-only board-specific information (serial number,=
=20
boot mode jumper configuration, ...) that are collected from various locati=
ons=20
(CPLD, flash, U-Boot, ...) to userspace applications.

Could anyone advice me on the preferred way to do that ? I can easily add a=
=20
quick&dirty sysfs/procfs based implementation, but I was wondering if there=
=20
was some kind of clean and generic way.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
