From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199909180118.SAA04037@falcon.csc.calpoly.edu>
Subject: unresolved symbol errors from insmod?
To: linuxppc-dev@lists.linuxppc.org (linuxdev)
Date: Fri, 17 Sep 1999 18:18:48 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK  I am still trying to get USB/PCI card on my PowerMac to work.  I have a
lot of problems but this one seems totaly wrong to me.

[root@batcave2 USB-2.2]# insmod usb-ohci.o 
usb-ohci.o: unresolved symbol schedule_timeout
usb-ohci.o: unresolved symbol __sti
usb-ohci.o: unresolved symbol misc_deregister
usb-ohci.o: unresolved symbol __wake_up
usb-ohci.o: unresolved symbol pci_dram_offset
usb-ohci.o: unresolved symbol atomic_dec
usb-ohci.o: unresolved symbol exit_fs
usb-ohci.o: unresolved symbol do_lost_interrupts
usb-ohci.o: unresolved symbol kmalloc
usb-ohci.o: unresolved symbol pci_find_class
usb-ohci.o: unresolved symbol __get_free_pages
usb-ohci.o: unresolved symbol ioremap
usb-ohci.o: unresolved symbol free_irq
usb-ohci.o: unresolved symbol ppc_n_lost_interrupts
usb-ohci.o: unresolved symbol kill_proc
usb-ohci.o: unresolved symbol iounmap
usb-ohci.o: unresolved symbol exit_mm
usb-ohci.o: unresolved symbol free_pages
usb-ohci.o: unresolved symbol del_timer
usb-ohci.o: unresolved symbol mod_timer
usb-ohci.o: unresolved symbol interruptible_sleep_on
usb-ohci.o: unresolved symbol __pollwait
usb-ohci.o: unresolved symbol kfree
usb-ohci.o: unresolved symbol dequeue_signal
usb-ohci.o: unresolved symbol misc_register
usb-ohci.o: unresolved symbol request_irq
usb-ohci.o: unresolved symbol kill_fasync
usb-ohci.o: unresolved symbol show_ohci_status
usb-ohci.o: unresolved symbol exit_files
usb-ohci.o: unresolved symbol loops_per_sec
usb-ohci.o: unresolved symbol fasync_helper
usb-ohci.o: unresolved symbol atomic_inc
usb-ohci.o: unresolved symbol add_mouse_randomness
usb-ohci.o: unresolved symbol jiffies
usb-ohci.o: unresolved symbol usb_show_device
usb-ohci.o: unresolved symbol set_bit
usb-ohci.o: unresolved symbol clear_bit
usb-ohci.o: unresolved symbol printk
usb-ohci.o: unresolved symbol kernel_thread
usb-ohci.o: unresolved symbol __cli
[root@batcave2 USB-2.2]# 

Now why can't insmod find these symbols?  I just previously I loaded the tulip
module which has many of the same symbols printk, pci_find_class etc. but with
this driver I get this...

I have checked my System.map file and all these symbols are there.

What is going on?

Ira Weiny


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
