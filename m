Return-Path: <carlos.mitidieri@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id C876667B40
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 22:21:45 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 31F3FFB879
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 12:21:43 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 184F1FB879
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 12:21:43 +0100 (CET)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id 7361220989A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 12:21:42 +0100 (CET)
From: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: pci-x
Date: Fri, 24 Mar 2006 12:21:44 +0100
References: <200603231435.01008.carlos.mitidieri@sysgo.com>
	<AD260576-EB34-4B56-9FB7-CE3A2DAEBFE7@kernel.crashing.org>
In-Reply-To: <AD260576-EB34-4B56-9FB7-CE3A2DAEBFE7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603241221.44576.carlos.mitidieri@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Thursday 23 March 2006 16:41, Kumar Gala wrote:
> > Is there PCI-X support for the mpc8540ads?
>
> Yes.  You have to make sure the board is setup (switches in the right
> place) properly for it.

Thank you for answering.

Looking the manuals and schematics,  I have changed the "config" switch in 
SW1, and now the PCI-X support is activated in the kernel at the system 
initialization. Nevertheless,  when I plug a bridge board to the slot 0, I 
get the following messages:

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: bridge 1 resource 1 moved to 9ff00000..9fffffff
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: bridge 1 resource 2 moved to 9fe00000..9fefffff

Would you guess that this is a driver problem, or that my board setup is still 
incorrect?

-- 
Carlos Mitidieri
SYSGO AG - Office Ulm
