Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FA25DDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 18:33:22 +1000 (EST)
Received: from [192.168.1.100]
	(CPE0018396a01fc-CM001225dbafb6.cpe.net.cable.rogers.com
	[99.236.101.138]) (authenticated bits=0)
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id l9B8WxEG018071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 04:33:10 -0400
Date: Thu, 11 Oct 2007 04:29:30 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: Kconfig selects non-existent IBM_NEW_EMAC_ZMII
Message-ID: <Pine.LNX.4.64.0710110427260.21029@localhost.localdomain>
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


  just FYI, from arch/powerpc/platforms/4xx/Kconfig:

...
config 440GP
        bool
        select IBM_NEW_EMAC_ZMII
...

  there is no such Kconfig variable IBM_NEW_EMAC_ZMII.

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
