From: tom_gall@vnet.ibm.com
Message-ID: <38FB305F.319624B1@vnet.ibm.com>
Date: Mon, 17 Apr 2000 15:40:15 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: prep_pci structures
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

  I'm trying to bring up a 7043 43p model 140. I'm making progress
however I've hit some code that I'm not quite sure what it means... thus
the post...

in arch/ppc/kernel/prep_pci.c

  What is the meaning of the structures at the beginning of the file?
Specifically:

static char ibm8xx_pci_IRQ_map[23] __prepdata = {
        0, /* Slot 0  - unused */
        0, /* Slot 1  - unused */
        0, /* Slot 2  - unused */
        0, /* Slot 3  - unused */
        0, /* Slot 4  - unused */
        0, /* Slot 5  - unused */
        0, /* Slot 6  - unused */
        0, /* Slot 7  - unused */
        0, /* Slot 8  - unused */
        0, /* Slot 9  - unused */
        0, /* Slot 10 - unused */
        0, /* Slot 11 - FireCoral */
        4, /* Slot 12 - Ethernet  PCIINTD# */
        2, /* Slot 13 - PCI Slot #2 */
        2, /* Slot 14 - S3 Video PCIINTD# */
        0, /* Slot 15 - onboard SCSI (INDI) [1] */
        3, /* Slot 16 - NCR58C810 RS6000 Only PCIINTC# */
        0, /* Slot 17 - unused */
        2, /* Slot 18 - PCI Slot 2 PCIINTx# (See below) */
        0, /* Slot 19 - unused */
        0, /* Slot 20 - unused */
        0, /* Slot 21 - unused */
        2, /* Slot 22 - PCI slot 1 PCIINTx# (See below) */
};


What are the "magic" numbers there? 4? 2? 0? What do those mean and how
are they used?

 Thanks!


http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
