Date: Wed, 18 Oct 2000 17:56:15 -0500 (CDT)
From: Grant Erickson <erick205@tc.umn.edu>
To: Zhaobin Zhu <zzhu@emc.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci_read_config_byte in Hardhat CDK1.2 for powerpc
In-Reply-To: <39EE1212.97CA8E71@emc.com>
Message-Id: <Pine.SOL.4.20.0010181752480.19084-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 18 Oct 2000, Zhaobin Zhu wrote:
> Anybody knows where the function "pci_read_config_byte(..)" is defined?

Search for 'PCI_OP' in drivers/pci.c. Also, there are machine-specific
routines defined in arch/ppc/*pci*.

Grant


--
 Grant M. Erickson                    University of Minnesota Alumni
  o mail:erick205@tc.umn.edu                              1996 BSEE
  o http://www.tc.umn.edu/~erick205/                      1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
