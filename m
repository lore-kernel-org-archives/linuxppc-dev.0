Date: 17 May 2002 15:12:12 -0000
Message-ID: <20020517151212.7749.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: usb on mpc823 in slave mode ..?
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello ,

I am putting efforts to initialise USB in slave mode on
mpc823.
when i connect to my pc i get messages like

usb-uhci.c: interrupt, status 2, frame# 1748
usb.c: USB device not accepting new address=19 (error=-110)

this makes me to doubt usb controller's interrupt at mpc823 is not
being requested, assuming onther intialisations are o.k.

I am using CPMVEC_SCC1  for my usb interupt that has been
defined as 0x1e..

also when I try to read pending interrupts from interrupt
controller( from usb controller routines) it always shows the 18th
bit in sipend register as pending.

i.e. o/p of
printk("pendinginterrupts is
0x%x\n",((immap_t*)IMAP_ADDR)->im_siu_conf.sc_sipend);

is 0x20000 , which is IRQ 3 as per manual.

any idea on this...

Best Regards,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
