Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
	[195.238.6.53]) by ozlabs.org (Postfix) with ESMTP id A9A1ADDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Oct 2007 19:41:54 +1000 (EST)
Received: from mail.technotrade.biz (localhost [127.0.0.1])
	by mail.technotrade.biz (Postfix) with ESMTP id 35E1B40C2
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Oct 2007 11:41:43 +0200 (CEST)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by mail.technotrade.biz (Postfix) with ESMTP id 26EE43D24
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Oct 2007 11:41:43 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: What's the preferred way to export board information to userspace ?
Date: Mon, 1 Oct 2007 11:41:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710011141.42269.laurentp@cse-semaphore.com>
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

I need to export some read-only board-specific information (serial number,=
=20
boot mode jumper configuration, ...) to userspace applications.

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
