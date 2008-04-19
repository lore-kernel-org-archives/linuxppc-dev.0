Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9486DE10B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:50:00 +1000 (EST)
Subject: Re: pci issue - wrong detection of pci ressources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <48088F02.2060806@linux.vnet.ibm.com>
References: <48088F02.2060806@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Sat, 19 Apr 2008 10:48:42 +1000
Message-Id: <1208566122.6958.425.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-18 at 14:07 +0200, Christian Ehrhardt wrote:
> => Region 2 is not detected with our kernel, this later break things
> like radeonfb initialization.

I'll need some information here:

- Your device-tree (is that the base sequoia one ?)
- Enable DEBUG in arch/powerpc/kernel/pci-common.c and pci_32.c
- Send me the resulting dmesg log
- Also include the output of /proc/iomem

Thanks !

Cheers,
Ben.
