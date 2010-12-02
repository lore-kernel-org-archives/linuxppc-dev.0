Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0E1CB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 04:47:15 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB2HlAJN032144
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Dec 2010 18:47:10 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Thu, 2 Dec 2010 18:47:09 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012021636.05963.dargaud@lpsc.in2p3.fr>
	<AANLkTinnXoU2kPEB-OmDWoWom18Nu9r0jOT==zWmRp4k@mail.gmail.com>
In-Reply-To: <AANLkTinnXoU2kPEB-OmDWoWom18Nu9r0jOT==zWmRp4k@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201012021847.09367.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>      grep -r irq_of_parse_and_map *
> 
> will give you plenty of examples.

OK, learning by example then.

Another basic question: 
what's the difference between of_register_platform_driver() and 
platform_driver_register() ?
I assume I must use the first one if I want to use irq_of_parse_and_map...
-- 
Guillaume Dargaud
http://www.gdargaud.net/
