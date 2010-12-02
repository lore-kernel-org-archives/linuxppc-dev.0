Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72462B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 02:36:12 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB2Fa6M8029660
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Dec 2010 16:36:06 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Thu, 2 Dec 2010 16:36:05 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012011735.58769.dargaud@lpsc.in2p3.fr>
	<20101201124142.15f75af7@udp111988uds.am.freescale.net>
In-Reply-To: <20101201124142.15f75af7@udp111988uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201012021636.05963.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> How was your driver probed?  If you can get a pointer to the device
> node, use irq_of_parse_and_map() to get a virtual irq that you can pass
> to request_irq().

Sounds like what I need... But I don't find irq_of_parse_and_map() in LDD 3rd 
ed and very few info in google. Are there some examples of use somewhere ?

> Can your driver tolerate it being shared?  If so, request it as shared.
I think so (not sure).
-- 
Guillaume Dargaud
http://www.gdargaud.net/
