Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C798679FA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 May 2005 19:23:29 +1000 (EST)
Received: from zambia.cambridgebroadband.com (cbluk-gw0.cambridgebroadband.com
	[217.204.121.82])
	by cambridgebroadband.com (8.12.8/8.12.8) with SMTP id j4V9NNU7011132
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 May 2005 10:23:24 +0100
Date: Tue, 31 May 2005 10:23:23 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20050531102323.0fbc2b5e.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: set_multicast_list() commented out in fcc_enet.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I've noticed that in arch/ppc/8260_io/fcc_enet.c at the very top of the
function set_multicast_list() there is a return statement - effectively
commenting out the rest of the code.  There is no comment saying why it
is there.

An effect of this is that you cannot put the device in promiscuous mode,
which is required when adding it to a bridge.

Please can anyone say why this "return;" is there?

Thanks,

Alex

PS I'm using denx's linuxppc_devel tagged 2005-03-06, which is based
on linux-2.4.25.
