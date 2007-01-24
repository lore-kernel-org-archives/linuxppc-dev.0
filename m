Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A074DE111
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 10:57:55 +1100 (EST)
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Krafft <krafft@de.ibm.com>
In-Reply-To: <20070125104540.65a1f557@localhost>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost> <200612210111.28186.arnd@arndb.de>
	<20070125104540.65a1f557@localhost>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 10:56:36 +1100
Message-Id: <1169682996.24996.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Christian@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	openipmi-developer@lists.sourceforge.net,
	Krafft <krafft@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +
> +static int __devexit ipmi_of_remove(struct of_device *dev)
> +{
> +	/* should call
> +	 * cleanup_one_si(dev->dev.driver_data); */
> +	return 0;
> +}

If your remove doesn't work, don't implement one. Though since you don't
have the choice in having a module_exit or not, you should really
implement one that works :-)

Ben.
