Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 717AF67A5E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 08:39:02 +1000 (EST)
Subject: Re: undefined reference to pci_io_base
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060829202831.GB27372@austin.ibm.com>
References: <44F47ABE.7080602@am.sony.com>
	<20060829202831.GB27372@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 08:38:36 +1000
Message-Id: <1156891116.8433.578.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >   #if defined(CONFI_PCI)
> >   extern unsigned long pci_io_base;
> >   #else
> >   #define pci_io_base 0
> >   #endif
> 
> This makes the most sense to me; it compiles to something nice.

Agreed.

Ben.
