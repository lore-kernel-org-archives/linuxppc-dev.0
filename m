From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15716.30526.816418.995714@argo.ozlabs.ibm.com>
Date: Thu, 22 Aug 2002 15:31:42 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: set_cfg_type
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I see that the indirect_pci methods only do Type 1 configuration
cycles for devices behind PCI-PCI bridges if ppc_md.set_cfg_type is
set.  Are there *any* host bridges for which we *don't* want to do
Type 1 cycles for devices behind PCI-PCI bridges?  If the answer is
no, let's get rid of ppc_md.set_cfg_type and do Type 1 cycles
unconditionally when dev->bus->number != hose->first_busno.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
