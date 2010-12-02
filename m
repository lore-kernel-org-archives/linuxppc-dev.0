Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65D1C1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 07:22:58 +1100 (EST)
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012021847.09367.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012021636.05963.dargaud@lpsc.in2p3.fr>
	<AANLkTinnXoU2kPEB-OmDWoWom18Nu9r0jOT==zWmRp4k@mail.gmail.com>
	<201012021847.09367.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 03 Dec 2010 07:22:51 +1100
Message-ID: <1291321371.32570.415.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-12-02 at 18:47 +0100, Guillaume Dargaud wrote:
> 
> OK, learning by example then.
> 
> Another basic question: 
> what's the difference between of_register_platform_driver() and 
> platform_driver_register() ?
> I assume I must use the first one if I want to use
> irq_of_parse_and_map... 

No. of_platform_drivers are more/less obsolete. Normal platform drivers
can now be associated with a device-tree node just fine.

Cheers,
Ben.
