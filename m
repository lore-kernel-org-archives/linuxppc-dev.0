Date: Sat, 15 Mar 2003 16:01:09 +0100
Message-Id: <HBSPPX$08BE7D73572C17E3728C4EA4A367D3E2@libero.it>
Subject: 
	=?iso-8859-1?Q?_interrupt_handler_registering_in_mpc850sar__:_i_need_help_!?=
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "=?iso-8859-1?Q?en=5Fch@libero.it?=" <en_ch@libero.it>
To: "=?iso-8859-1?Q?linuxppc-embedded?=" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i have to realize a char driver to set ATM Utopia for a linux
embedded system using motorola mpc850sar.

i need help with registering the interrupt handler function: i tried
to use request_8xxirq() for the SIU and cpm_install_handler() for CPM
but interrupt handler seems not run when i trasmit and receive. which is
the correct interrupt handler registering function ? or is just a
registers setting problem ? how can i do ?

how can i configure interrupt?

thanks

en_ch@libero.it


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
