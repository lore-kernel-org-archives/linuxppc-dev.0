Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04B9667BB3
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 08:07:10 +1000 (EST)
Subject: Re: Selecting the ppc_md.power_save method at boot time
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200610201840.14389.arnd.bergmann@de.ibm.com>
References: <200610201840.14389.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 08:05:47 +1000
Message-Id: <1161381947.10524.205.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anthony J Marsala <marsala@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Is anyone interested in the second solution? Otherwise I'd post
> a simple patch to just do powersave=off.

Simple solution sounds good to me.

Ben.
