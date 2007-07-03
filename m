Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E1B2DDEED
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 19:17:55 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l639HoCW027838
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 04:17:51 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <790E72AD-637C-4C13-8266-CDD285573DF6@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Patches added to for_paulus (queue'd for 2.6.23)
Date: Tue, 3 Jul 2007 04:17:41 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm still working through the back log of patches related to ppc32/ 
fsl.  If there are patches people want to make sure get into 2.6.23  
let me know.

David Gibson (2):
       [POWERPC] Split out asm-ppc/mmu.h portions for Freescale Book-E
       [POWERPC] Split out asm-ppc/mmu.h portions for PowerPC 8xx

Jon Loeliger (1):
       [POWERPC] Replace use of GET_64BIT(prop, i) with of_read_number 
().

Kumar Gala (4):
       [POWERPC] Reworked interrupt numbers for OpenPIC based  
Freescale chips
       [POWERPC] Kill pcibios_enable_resources()
       [POWERPC] Fix up interrupt senses for MPC85xx boards
       [POWERPC] Merge asm-ppc/mmu_context.h into asm-power/ 
mmu_context.h

Li Yang (1):
       [POWERPC] qe_lib: export symbols for QE driver to compile as  
module

Roy Zang (4):
       [POWERPC] Document the global utilities node define and example
       [POWERPC] Fix the node index confusion for SOC
       [POWERPC] 85xx: Fix 8548CDS reset bug
       [POWERPC] Remove redundant pci_read_irq_line() function for  
85xx platform

Timur Tabi (1):
       [POWERPC] Fix MAC address entries for 83xx, 85xx, and 86xx  
device trees


These two patches are queue, but not in the tree (or will be after  
some other depency):
* 83xx USB platform code rework
* bootwrapper: adds cuboot for MPC7448HPC2 platform

- k
