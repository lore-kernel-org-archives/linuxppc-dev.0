From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problem in pmac PCI fixup
Date: Sun, 28 Apr 2002 17:16:09 +0200
Message-Id: <20020428151609.30064@smtp.wanadoo.fr>
In-Reply-To: <E171qYc-0000AJ-00@piglet.grunz.lu>
References: <E171qYc-0000AJ-00@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>--- linux-2.4.19-pre6-lvm-gentoo/arch/ppc/kernel/pmac_pci.c     Sun Apr
>28 09:14:09 2002
>+++ linux-2.4.16-planb/arch/ppc/kernel/pmac_pci.c       Sun Apr
>28 17:18:39 2002
>@@ -493,8 +503,6 @@
>                unsigned char pin;
>                struct device_node* node;
>
>-               if (pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin) ||
>!pin)
>-                       continue; /* No interrupt generated -> no fixup */
>                node = pci_device_to_OF_node(dev);
>                if (!node) {
>                        printk("No OF node for device %x:%x\n", dev->bus-
>>number, dev->devfn >> 3);
>
>Anybody have any problem with that approach?

No problem with that, it's actually what we do in chrp.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
