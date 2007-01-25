Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 485A4DE04B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 11:31:01 +1100 (EST)
In-Reply-To: <1169682996.24996.11.camel@localhost.localdomain>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost>
	<200612210111.28186.arnd@arndb.de>
	<20070125104540.65a1f557@localhost>
	<1169682996.24996.11.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <523FF36A-46DF-40CA-BFFE-EDE95EFA3EFE@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
Date: Thu, 25 Jan 2007 01:29:48 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christian Krafft <krafft@de.ibm.com>,
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

>> +static int __devexit ipmi_of_remove(struct of_device *dev)
>> +{
>> +	/* should call
>> +	 * cleanup_one_si(dev->dev.driver_data); */
>> +	return 0;
>> +}
>
> If your remove doesn't work, don't implement one.

As explained before, it's the underlying thing that doesn't
work.  Yeah someone should fix it one day.  Still it's better
to have this comment than to not have anything at all.  An
XXX FIXME: tag wouldn't be out of place of course.

> Though since you don't
> have the choice in having a module_exit or not, you should really
> implement one that works :-)

Genau.


Segher
