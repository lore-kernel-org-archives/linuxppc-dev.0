MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: USB questions (for the MPC8xx)
Date: Fri, 16 Mar 2001 12:52:10 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A9116@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <karid@flaga.is>
To: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	<linux-usb-devel@lists.sourceforge.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

In the m8xxhci.c hci driver for the mpc one can select to use TIMER1 for
the SOF generator.
A interruopt handler, m8xxhci_timer_interrupt() is registered to handle
this interrupt and generate the SOF.
Why is it then that the timer is also exported to PA6?
Why is it the the USE_TIMER1_FOR_SOF is defined within the
USE_UCODE_PATCH which is for external generated SOF-interrupt?
Isn't the timer option exactly for the case where you do not have
externally generated SOF-interrupt?
If we can use a timer for generating the SOF why can't we just use a
regular kernel timer instead, and therfore free one timer or baud rate
generator?

Thanks,

K.D.

P.S. sorry for the x-post I am not shure if this belongs to the embedded
list or the usb list.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
