Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8FFBDDF4A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:02:36 +1100 (EST)
Subject: Re: [PATCH 2.6.21-rc1] powerpc: Make
	of_device_uevent()	compatible	with ibmebus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joachim Fenkes <FENKES@de.ibm.com>
In-Reply-To: <OF18F067AE.FF85D78B-ON85257287.005ADAC3-85257287.005B37D9@de.ibm.com>
References: <OF18F067AE.FF85D78B-ON85257287.005ADAC3-85257287.005B37D9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 20 Feb 2007 06:47:52 +1100
Message-Id: <1171914472.18571.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: pmac@au1.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> If I make the root device a basic struct device, it can't be part of 
> ibmebus any
> longer. If we could create a busless device, we wouldn't have a problem, 
> but I
> doubt that is possible.
> 
> Do you have any creative ideas?

Well, I think PCI does just that for PCI busses ... (a busless device)

Ben.

> > It's a generic problem with sysfs, I agree it somewhat sucks.
> 
> With ya.
> 
> Later,
>   Joachim
> 
> ---
> Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer 
> extraordinaire
> IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Development 
> 2)
> Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
> eMail: fenkes@de.ibm.com  --  Phone: +49 7031 16 1239 
> 
> Vorsitzender des Aufsichtsrats: Johann Weihen  --  Geschäftsführung: 
> Herbert Kircher
> Sitz der Gesellschaft: Böblingen  --  Registergericht: Amtsgericht 
> Stuttgart, HRB 243294
