Date: Tue, 18 Mar 2003 16:59:45 +0100
Message-Id: <HBYCFL$662FE8F3AA02562685A2FED9FE2287DA@libero.it>
Subject: =?iso-8859-1?Q?Problem_with_interrupts_handling?=
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "=?iso-8859-1?Q?en=5Fch@libero.it?=" <en_ch@libero.it>
To: "=?iso-8859-1?Q?linuxppc-embedded?=" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all!!

I have to realize a char driver to set ATM Utopia for a linux
embedded system using motorola mpc850sar.

I need help to cofigure interrupt (maybe with registering the interrupt handler function).I used this code

if(request_8xxirq(INTERRUPT_LEVEL, MyHandler, 0, DEVICE_NAME, NULL)
panic("Could not allocate irq");
cpm_install_handler(CPMVEC_IDMA1, MyHandler, NULL);

(note that INTERRUPT_LEVEL = 4 and CPMVEC_IDMA1 = 0x15)

I think i set correctly all the cpm and siu registers but it doesn't work!!!!!

is this the right code??
Or there are errors in setting the registers???
Can someone help me?!??!!!!

Tanks a lot!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
