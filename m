Date: 9 Jul 2002 13:50:30 -0000
Message-ID: <20020709135030.28935.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: klogd and usb printk's..
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


during elaborate testing of usb i found a issue..
If i use in USB interrupt routine ( slave on 823/850)
with printk's with any logging option and don't start klogd it
works.

after starting klogd it stops working even recv. and xmit
interrupts stops.
kill klogd it again wotks fine.

klogd just setting a logging level that will prohibit usb printk's
to go got console printing.

if i use printk with KERN_EMERG/KERN_ALERT kind of options it
again wotks fine also simply with klogd -c 7.

point out of all this  is it works fine when printk's inside it go
for a console printing.

usb (scc1) is among highest priority while console(smc1) is quite
lower ..do i need to put some delays to take care of printk's

anybody has experienced the similar issue ..?
_________________________________________________________
There is always a better job for you at Monsterindia.com.
Go now http://monsterindia.rediff.com/jobs


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
