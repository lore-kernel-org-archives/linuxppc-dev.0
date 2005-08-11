Return-Path: <vijaykumar@bravegnu.org>
Received: from chtn.777servers.com (unknown [70.86.14.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3736680AB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 06:33:28 +1000 (EST)
From: Vijay Kumar <vijaykumar@bravegnu.org>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 11 Aug 2005 11:17:58 +0530
Message-Id: <1123739278.19079.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: dmalek@jlc.net
Subject: 8260 fcc_enet driver newbie question
Reply-To: vijaykumar@bravegnu.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I was going through the fcc_enet driver
(linux-2.6.12.2/arch/ppc/8260_io/fcc_enet.c).

The driver accesses the CPM memory map using 
immap = (cpm2_map_t *)CPM_MAP_ADDR;

There is also a global variable cpm2_immr defined in
arch/ppc/syslib/cpm2_common.c

If I were to write a new driver which one should I use
to access the CPM memory map?

Vijay
