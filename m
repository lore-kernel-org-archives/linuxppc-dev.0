From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199909152235.PAA09175@falcon.csc.calpoly.edu>
Subject: Re: Asante 10/100 Rev. b now working!
To: bakerc@pacbell.net
Date: Wed, 15 Sep 1999 15:35:04 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org (linuxdev)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This should be defined here.

pci-netif.c:
 
#if (LINUX_VERSION_CODE >= 0x20100)
char kernel_version[] = UTS_RELEASE;
#else
#define PCI_CAPABILITY_LIST   0x34  /* Offset of first capability list entry */
#define PCI_STATUS_CAP_LIST   0x10  /* Support Capability List */
#define PCI_CAP_ID_PM      0x01  /* Power Management */
#endif
 

Check LINUX_VERSION_CODE in /usr/src/linux/include/linux/version.h
And then /usr/src/linux/include/linux/pci.h for PCI_STATUS_CAP_LIST

Either way PCI_STATUS...  Should be defined.

Maybe you don't have the kernel headers installed?
Just a guess.

Ira Weiny


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
