Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (unknown [192.88.165.103])
	by ozlabs.org (Postfix) with ESMTP id 7A4DB67A44
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Apr 2006 13:52:12 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k3441O8x009883
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Apr 2006 21:01:24 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k343rGXu007571
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Apr 2006 22:53:17 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673081427@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: linuxppc-embedded@ozlabs.org
Subject: of_platform bus?
Date: Tue, 4 Apr 2006 11:52:05 +0800 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I noticed that there is a new bus type of_platform_bus added.  Current ppc embedded systems are using platform_device, and are changing to use OF flat device tree structure.  Does it mean that current drivers need to be switched from platform_bus to of_platform_bus?

--
Regards,
Leo
