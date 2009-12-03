Return-Path: <jeff.hane@maxim-ic.com>
Received: from antispam02.maxim-ic.com.maxim-ic.com (antispam02.maxim-ic.com
	[205.153.101.183]) by ozlabs.org (Postfix) with ESMTP id 00C02B7C2D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2009 17:33:57 +1100 (EST)
Received: from mailhost.mobilygen.com (localhost [127.0.0.1])
	by antispam02.maxim-ic.com.maxim-ic.com (Spam & Virus Firewall) with
	ESMTP id 3C18A6A7D7E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2009 00:18:35 -0600 (CST)
Received: from mailhost.mobilygen.com ([10.32.80.116]) by
	antispam02.maxim-ic.com.maxim-ic.com with ESMTP id
	2HeQRTL6iuE0Vkuu for <linuxppc-dev@ozlabs.org>;
	Thu, 03 Dec 2009 00:18:35 -0600 (CST)
Received: from [10.32.80.202] (qu102 [10.32.80.202]) (authenticated bits=0)
	by mailhost.mobilygen.com (8.13.8/8.13.8) with ESMTP id nB36IWIo002326
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Dec 2009 22:18:33 -0800
Subject: PCI interrupt question
From: Jeff Hane <jeff.hane@maxim-ic.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 02 Dec 2009 22:21:56 -0800
Message-Id: <1259821316.12651.26.camel@qu102.quarc.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, 

 I'm trying to get interrupts working for my PCI device on a 460ex and
am having problem.  My ISR never triggers.

I'm new to PCI(and ppc) and LDD said that I could read the config reg
INTURRUPT_LINE to get the interrupt assigned to my PCI device.  Well,
this always reads zero. 

After reading through the code it appears that the interrupt is being
assigned after reading some information out of the device tree and then
filling in the irg in the pci_dev structure.  

I'm just looking for confirmation that I should be calling request_irq
with the irq that I found in the pci_dev struct.

thanks,
jeff
