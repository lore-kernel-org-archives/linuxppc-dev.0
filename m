Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030612014745.47244.qmail@web41509.mail.yahoo.com>
Date: Wed, 11 Jun 2003 18:47:45 -0700 (PDT)
From: Bruno Li <libruno@yahoo.com>
Subject: What to change on u-boot if we want to remove SPD EEPROM?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

We want to remove SPD EEPROM on ppc440gp to lower the
expense. The plan is to change u-boot code to use a
memory buffer (filled with the content of SPD EEPROM).
Is this possible?

I removed the SPD EEPROM on my ppc440gp board, and
changed u-boot code to use a memory buffer whenever
the code need to access SPD EEPROM, however, I found
that pci bus scan fails, u-boot stops at this line (of
pci_hose_scan_bus() in drivers/pci.c:
pci_hose_read_config_byte(hose, dev, PCI_HEADER_TYPE,
&header_type);

What extra initialization should I do when SPD EEPROM
is missing from the system?

Thanks,

Bruno


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
