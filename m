Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 38DDC67A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 03:58:44 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <46a39a3ece66c48a2679e5b6dc3c24b0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 30 Mar 2005 11:58:41 -0600
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: 36-bit phys & 64-bit pte support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt,

It looks like you introduced two config options at one point, however 
they dont seem to be used consitently today.  I wanted to clarify the 
meaning that I'm going to try and go forward with:

CONFIG_PTE_64BIT - we have a 64-bit PTE
CONFIG_PHYS_64BIT - we have larger than 32-bit physical addresses

Its feasible to have support for CONFIG_PTE_64BIT while only supporting 
32-bit phys.  The intent would be if you needed more flags than you 
could handle in the 12 LSBs of the pte.

CONFIG_PHYS_64BIT will only effect things like ioremap, phys_addr_t, 
etc.

Do you agree with this interpretation?

- kumar 
  
