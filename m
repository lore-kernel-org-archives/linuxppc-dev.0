Return-Path: <mahendravarman15@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id B2B70DDFCD
	for <linuxppc-embedded@ozlabs.org.>;
	Thu,  6 Mar 2008 01:45:00 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id k20so807933rvb.3
	for <linuxppc-embedded@ozlabs.org.>;
	Wed, 05 Mar 2008 06:44:58 -0800 (PST)
Message-ID: <4ac2955e0803050644g2ccd2e46n305d2790389b517@mail.gmail.com>
Date: Wed, 5 Mar 2008 20:14:57 +0530
From: "mahendra varman" <mahendravarman15@gmail.com>
To: linuxppc-embedded@ozlabs.org., linux-kernel@vger.kernel.org
Subject: Unresolved symbols while inserting a module in linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

For a customised hdlc card we have written hdlc driver.
we need to compile it as a module in linux 2.4.25 version
Thru Config.in we have defined the customised driver as tristate and
selected 'M' in menuconfig for that driver
The other dependencies generic hdlc driver, cisco , framedelay , ppp
etc are compiled as configured within the kernel itself
By giving make modules we have produced driver.o file

When I insert the driver.o using insmod iam getting the following
unresolved symbols
Even though the dependencies have been configured with the kernel
itself iam getting these unresolved symbols

If we use modprobe driver.o (or) modprobe driver it is reporting
driver:applet not found..

Help me to produce a module with its dependencies also to solve the
unresolved symbols error


Thanks

---------------------------------------------------- unresolved
symbols after insmod
------------------------------------------------------

Using driver.o
insmod: unresolved symbol pci_write_config_byte
insmod: unresolved symbol __netdev_watchdog_up
insmod: unresolved symbol schedule_timeout
insmod: unresolved symbol __kfree_skb
insmod: unresolved symbol alloc_skb
insmod: unresolved symbol pci_register_driver
insmod: unresolved symbol register_hdlc_device
insmod: unresolved symbol unregister_hdlc_device
insmod: unresolved symbol __release_region
insmod: unresolved symbol kmalloc
insmod: unresolved symbol pci_free_consistent
insmod: unresolved symbol pci_free_consistent
insmod: unresolved symbol __save_flags_ptr
insmod: unresolved symbol ioremap
insmod: unresolved symbol cpu_raise_softirq
insmod: unresolved symbol free_irq
insmod: unresolved symbol __out_of_line_bug
insmod: unresolved symbol iounmap
insmod: unresolved symbol pci_alloc_consistent
insmod: unresolved symbol iomem_resource
insmod: unresolved symbol kfree
insmod: unresolved symbol strlen
insmod: unresolved symbol request_irq
insmod: unresolved symbol netif_rx
insmod: unresolved symbol pci_unregister_driver
insmod: unresolved symbol skb_over_panic
insmod: unresolved symbol pci_set_master
insmod: unresolved symbol hdlc_ioctl
insmod: unresolved symbol jiffies
insmod: unresolved symbol __copy_tofrom_user
insmod: unresolved symbol __restore_flags
insmod: unresolved symbol softnet_data
insmod: unresolved symbol __request_region
insmod: unresolved symbol printk
insmod: unresolved symbol __cli
