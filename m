Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 945D067B1C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 22:10:58 +1000 (EST)
Subject: Re: _machine removal breaks kexec?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@us.ibm.com>
In-Reply-To: <44316705.1040202@us.ibm.com>
References: <20060403014044.GA4704@krispykreme>
	<1144080994.4449.10.camel@localhost.localdomain>
	<1078253E-4B9E-4432-86E3-82B01A4B68D1@kernel.crashing.org>
	<44316705.1040202@us.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 14:05:15 +0200
Message-Id: <1144152315.4449.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Basically, kexec-tools looks the platform property to determine whether 
> to read tce-base, tce-size and htab-* properties. The attached patch 
> find out the platform info based on /proc/device-tree/chosen/htab-base 
> property. Not tested yet.

You should just test if the properties exist ...

> Kumar,  kexec-tools completely depends on device-tree.  Not sure whether 
> the embedded system exports the device-tree.

With arch=powerpc, they do
