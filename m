Return-Path: <auke-jan.h.kok@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id DD2F2DDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 03:11:06 +1000 (EST)
Message-ID: <46AE192E.4080205@intel.com>
Date: Mon, 30 Jul 2007 10:00:30 -0700
From: "Kok, Auke" <auke-jan.h.kok@intel.com>
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/4][RFC] lro: Kconfig and Makefile
References: <200707301724.45781.ossthema@de.ibm.com>
	<20070730172535.15993806@oldman.hamilton.local>
	<46AE1383.3050305@garzik.org>
In-Reply-To: <46AE1383.3050305@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Andrew Gallatin <gallatin@myri.com>,
	Stephen Hemminger <shemminger@linux-foundation.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Garzik wrote:
> Stephen Hemminger wrote:
>> Why make this a user selectable option at all? Unless you want
>> to deal with out of tree drivers (not my problem), it should be hidden
>> to avoid having to explain an support it.
> 
> In this case it's an optional library kernel module.  That seems to be a 
> common setup for library modules.  We do the same with CONFIG_MII and 
> drivers/net/mii.ko as well.
> 
> Originally it was done purely in the Makefile, but that does not account 
> for net drivers in sub-directories (or out of tree as you point out).

speaking of that, shouldn't there be a NETIF_F_LRO ?

Auke
