Date: Mon, 17 Mar 2003 17:36:21 +0100
Message-Id: <HBWJGL$83928DADC592905EE536408396161CE6@libero.it>
Subject: 
	=?iso-8859-1?Q?Re:__interrupt_handler_registering_in_mpc850sar__:_i_need_help_!?=
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "=?iso-8859-1?Q?en=5Fch@libero.it?=" <en_ch@libero.it>
To: "=?iso-8859-1?Q?linuxppc-embedded?=" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i have to realize a char driver to set ATM Utopia for a linux embedded system
using motorola mpc850sar.

i Tried this :

if(request_8xx(INTERRUPT_LEVEL,myInterruptHandler,0,DEVICE_NEME,NULL))
   panic("could not allocate irq!\n");
cpm_install_handler(CPMVEC_IDMA1,myInterruptHandler,NULL);

is it correct ??? note: INTERRUPT_LEVEL is defined 4 and CPMVEC_IDMA1 is 0x15.

which register must i set (and how) to configure  interrupt in utopia mode ?
i have seen that siu and cpm register is setted by kernel... i think i have just
to register the handler.
Please help me !


en_ch
we r desperate :)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
