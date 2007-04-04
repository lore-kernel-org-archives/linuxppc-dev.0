Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22FABDDECD
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:25:38 +1000 (EST)
Date: Wed, 4 Apr 2007 02:28:28 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404022828.5c9b97f3@the-village.bc.nu>
In-Reply-To: <20070403.181645.68159458.davem@davemloft.net>
References: <1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403.181645.68159458.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't need to know anything about the inanrds of my computer to
> bring up the ethernet interface, me caveman me bringup eth0, me on
> network, caveman happy.  The same should be true for serial ports.

You don't get machines with 64 ethernet ports on add-in cards. There are
good reasons for the naming schemes in use.

Alan
