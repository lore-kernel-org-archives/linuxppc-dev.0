Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5059DDD0D
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 08:22:50 +1000 (EST)
Received: from [192.168.1.102]
	(CPE0018396a01fc-CM001225dbafb6.cpe.net.cable.rogers.com
	[72.143.66.27]) (authenticated bits=0)
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id l6EMLGxB009616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 18:21:24 -0400
Date: Sat, 14 Jul 2007 18:19:35 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: possible dead CONFIG-related content under arch/powerpc
Message-ID: <Pine.LNX.4.64.0707141816470.9751@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  not sure if this is still the right ML, but here's the equivalent
unreferenced content under arch/powerpc:

========== FC_ENET_HAS_SCC ==========
arch/powerpc/platforms/8xx/mpc885ads_setup.c:109:#ifndef CONFIG_FC_ENET_HAS_SCC
========== SMP_750 ==========
arch/ppc/mm/tlb.c:92:#ifdef CONFIG_SMP_750
arch/powerpc/mm/tlb_32.c:92:#ifdef CONFIG_SMP_750
========== SPE_BASE ==========
arch/powerpc/mm/hash_utils_64.c:612:#ifdef CONFIG_SPE_BASE
arch/powerpc/mm/hash_utils_64.c:747:#ifdef CONFIG_SPE_BASE

-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
