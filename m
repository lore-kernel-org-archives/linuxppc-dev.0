Return-Path: <abg.mur22@yahoo.com>
Received: from n28.bullet.mail.mud.yahoo.com (n28.bullet.mail.mud.yahoo.com
	[68.142.206.223]) by ozlabs.org (Postfix) with SMTP id 043A2DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 08:15:01 +1000 (EST)
Date: Thu, 18 Sep 2008 15:08:45 -0700 (PDT)
From: Abg Abg <abg.mur22@yahoo.com>
Subject: Network driver on ppc 405EX
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-946499256-1221775725=:22518"
Message-ID: <371343.22518.qm@web59716.mail.ac4.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-946499256-1221775725=:22518
Content-Type: text/plain; charset=us-ascii

Hi, 
  Hope this is the correct list for driver related queries for ppc boards

I was porting a network driver for a ppc 405EX based embedded system (kilauea config).
The module builds fine and loads and I see the probe routine get called correctly.
However when I try remapping the BAR0 address from the PCI config space, the ioremap fails.
A little debugging showed that the address passed to ioremap was zero.
I pass the address to the ioremap via pci_resource_start(pdev, 0) where pdev is a type struct pci_dev *.

I dumped the contents of the pdev and saw that the vendor-id, device id etc were correct, however the BAR0 address seemed to be all zeroes.

The question that I had was
1. Is there any kernel config that needs to be done for PCI devices to be able to remap the BAR0 addresses.
2. Any other kernel parameter that needs to be tweaked?

Thanks,
Abg


      
--0-946499256-1221775725=:22518
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hi, <br>&nbsp; Hope this is the correct list for driver related queries for ppc boards<br><br>I was porting a network driver for a ppc 405EX based embedded system (kilauea config).<br>The module builds fine and loads and I see the probe routine get called correctly.<br>However when I try remapping the BAR0 address from the PCI config space, the ioremap fails.<br>A little debugging showed that the address passed to ioremap was zero.<br>I pass the address to the ioremap via pci_resource_start(pdev, 0) where pdev is a type struct pci_dev *.<br><br>I dumped the contents of the pdev and saw that the vendor-id, device id etc were correct, however the BAR0 address seemed to be all zeroes.<br><br>The question that I had was<br>1. Is there any kernel config that needs to be done for PCI devices to
 be able to remap the BAR0 addresses.<br>2. Any other kernel parameter that needs to be tweaked?<br><br>Thanks,<br>Abg<br><br><br><br></div></div><br>



      </body></html>
--0-946499256-1221775725=:22518--
