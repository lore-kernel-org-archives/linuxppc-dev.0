Return-Path: <carlos.moratelli@digitel.com.br>
Received: from atena.digitel.com.br (ares.digitel.com.br [200.198.105.40])
	by ozlabs.org (Postfix) with ESMTP id 14A14B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 21:30:33 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by atena.digitel.com.br (Postfix) with ESMTP id 2816932E8002
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 08:23:31 -0300 (BRT)
Received: from atena.digitel.com.br ([127.0.0.1])
	by localhost (atena.digitel.com.br [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id c1-tH3sN8B0G for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 08:23:29 -0300 (BRT)
Received: from [192.168.20.159] (unknown [192.168.20.159])
	by atena.digitel.com.br (Postfix) with ESMTP id 5FAD932E8001
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 08:23:28 -0300 (BRT)
Subject: Doubt about Linux PCIe infraestructure
From: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain
Date: Tue, 28 Sep 2010 08:16:05 -0300
Message-Id: <1285672565.6920.3.camel@parana.digitel.com.br>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have a simple doubt about linux PCI/PCIe infraestructure.  

When I register a PCI driver using pci_register_driver() will the 
probe function be automatically called or will it just be called if PCI 
infraestructure match a Vendor and Device id on bus?

I am loading a PCI driver that register itself using 
pci_register_driver() but the probe function isn't called.

thanks,

Carlos R. Moratelli
