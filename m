Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20021017100442.71539.qmail@web8005.mail.in.yahoo.com>
Date: Thu, 17 Oct 2002 03:04:42 -0700 (PDT)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: IMMR for fads mpc860
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I would like to know what is the physical address of
Internal memory mapped register for the fads mpc860
board ..
and please verify if the values of the registers are
correct in the file
/Linux-Kernel /include/asm-ppc/fads.h

#define BCSR_ADDR               ((uint)0xff010000)
#define BCSR_SIZE               ((uint)(64 * 1024))
#define BCSR0                   ((uint)0xff010000)
#define BCSR1                   ((uint)0xff010004)
#define BCSR2                   ((uint)0xff010008)
#define BCSR3                   ((uint)0xff01000c)
#define BCSR4                   ((uint)0xff010010)
#define IMAP_ADDR               ((uint)0xff000000)
#define IMAP_SIZE               ((uint)(64 * 1024))

#define PCMCIA_MEM_ADDR         ((uint)0x50000000)
#define PCMCIA_MEM_SIZE         ((uint)(64 << 20 ))

#define _IO_BASE                ((uint)0x80000000)
#define _IO_BASE_SIZE            0x1000

#define CFG_ATA_IDE0_OFFSET     0x0000

#define CFG_ATA_BASE_ADDR       PCMCIA_MEM_ADDR
#define CFG_ATA_DATA_OFFSET     (CFG_PCMCIA_MEM_SIZE +

                                                 x320)
#define CFG_ATA_REG_OFFSET    (2 *
                          CFG_PCMCIA_MEM_SIZE + 0x320)
#define CFG_ATA_ALT_OFFSET      0x0100

#define MAX_HWIFS               1
#define IDE0_BASE_OFFSET        0
#define IDE0_DATA_REG_OFFSET    (PCMCIA_MEM_SIZE +
                                               0x320)
#define IDE0_ERROR_REG_OFFSET   (2 * PCMCIA_MEM_SIZE +

                                             0x320 +
1)
#define IDE0_NSECTOR_REG_OFFSET (2 * PCMCIA_MEM_SIZE +

                                            0x320 + 2)
#define IDE0_SECTOR_REG_OFFSET  (2 * PCMCIA_MEM_SIZE +

                                            0x320 + 3)
#define IDE0_LCYL_REG_OFFSET    (2 * PCMCIA_MEM_SIZE +

                                            0x320 + 4)
#define IDE0_HCYL_REG_OFFSET    (2 * PCMCIA_MEM_SIZE +

                                            0x320 + 5)
#define IDE0_SELECT_REG_OFFSET  (2 * PCMCIA_MEM_SIZE +

                                             0x320 +
6)
#define IDE0_STATUS_REG_OFFSET  (2 * PCMCIA_MEM_SIZE +

                                             0x320 +
7)
#define IDE0_CONTROL_REG_OFFSET 0x0106
#define IDE0_IRQ_REG_OFFSET     0x000A  /* not
                           used                     */

/* Bits of interest in the BCSRs.
 */
#define BCSR1_ETHEN             ((uint)0x20000000)
#define BCSR1_RS232EN_1         ((uint)0x01000000)
#define BCSR1_RS232EN_2         ((uint)0x00040000)
#define BCSR4_ETHLOOP      ((uint)0x80000000)      /*
EEST Loopback */
#define BCSR4_EEFDX    ((uint) 0x40000000)      /*
EEST FDX enable */
#define BCSR4_FETH_EN      ((uint)0x08000000)      /*
PHY enable */
#define BCSR4_FETHCFG0    ((uint)0x04000000)      /*
PHY autoneg mode */
#define BCSR4_FETHCFG1     ((uint)0x00400000)      /*
PHY autoneg mode */
#define BCSR4_FETHFDE      ((uint)0x02000000)      /*
PHY FDX advertise */
#define BCSR4_FETHRST      ((uint)0x00200000)      /*
PHY Reset */

/* Interrupt level assignments.
 */
#define FEC_INTERRUPT           SIU_LEVEL1      /* FEC
interrupt */
#define PHY_INTERRUPT           SIU_IRQ2        /* PHY
link change interrupt */
#define IDE0_INTERRUPT          13

/* We don't use the 8259.
 */
#define NR_8259_INTS    0

/* Machine type
 */
#define _MACH_8xx (_MACH_fads)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
