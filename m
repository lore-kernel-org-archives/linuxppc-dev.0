Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 5304ADDECD
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 01:32:44 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 5/9] kill isa_{io,mem}_base definitions for !PCI
Date: Sun, 17 Jun 2007 17:32:43 +0200
References: <20070616000511.712667424@arndb.de>
	<20070616000618.706193913@arndb.de>
	<43F789E2-BBB2-4382-9DA2-619357E9E006@kernel.crashing.org>
In-Reply-To: <43F789E2-BBB2-4382-9DA2-619357E9E006@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706171732.43969.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 17 June 2007, Kumar Gala wrote:
> > -#ifndef CONFIG_PCI
> > -isa_io_base =3D MPC7448_HPC2_ISA_IO_BASE;
> > -isa_mem_base =3D MPC7448_HPC2_ISA_MEM_BASE;
> > -pci_dram_offset =3D MPC7448_HPC2_PCI_MEM_OFFSET;
> > -#endif
> > -
> > =A0extern void _nmask_and_or_msr(unsigned long nmask, unsigned long =A0
> > or_val);
>=20
> can you remove the defines in mpc7448_hpc2.h since they are appear to =A0
> only be used here.

Ok, good idea.
