Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF0D8DDF40
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 02:36:26 +1000 (EST)
Message-ID: <46AE1383.3050305@garzik.org>
Date: Mon, 30 Jul 2007 12:36:19 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [PATCH 2/4][RFC] lro: Kconfig and Makefile
References: <200707301724.45781.ossthema@de.ibm.com>
	<20070730172535.15993806@oldman.hamilton.local>
In-Reply-To: <20070730172535.15993806@oldman.hamilton.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Andrew Gallatin <gallatin@myri.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Hemminger wrote:
> Why make this a user selectable option at all? Unless you want
> to deal with out of tree drivers (not my problem), it should be hidden
> to avoid having to explain an support it.


In this case it's an optional library kernel module.  That seems to be a 
common setup for library modules.  We do the same with CONFIG_MII and 
drivers/net/mii.ko as well.

Originally it was done purely in the Makefile, but that does not account 
for net drivers in sub-directories (or out of tree as you point out).

	Jeff
