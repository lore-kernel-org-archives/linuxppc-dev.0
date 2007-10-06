Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3D702DDE46
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 23:36:32 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C2771B73-A555-4119-AC21-1441D4CC2125@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: TASK_SIZE default 0x80000000 ?
Date: Sat, 6 Oct 2007 08:36:23 -0500
To: PowerPC dev list <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In a discussion with Hollis over beer he raised the question why  
TASK_SIZE is 0x80000000 on ppc32.

I was wondering if anyone know why this was still the case?  Seems  
like we have a 1Gb whole between TASK_SIZE & KERNELBASE.

- k
