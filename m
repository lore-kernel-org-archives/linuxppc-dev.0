Date: 24 Jun 2002 16:42:45 -0000
Message-ID: <20020624164245.25843.qmail@webmail11.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: scc2 conflict with usb?
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am able to run a usb slave driver in linux 2.4.7 on 823/850
(rpxlite) boards.
problem being faced is that usb (scc1 addres space) works when my
CPM ENET is not either at SCC1 or SCC2.
when I enable ENET on SCC3 my UART conflicts and says during
compilation
uart.c:68: #error "Can't use SMC1 for console with Ethernet on
SCC3"

guided by this now when i enable console on SMC2 it compliles but
no o/p during booting on screen.

looks like uart.c file need to be looked upon.

ENET on SCC1 would conflict with USB as there would be clash of
interrupts (CPMVEC_SCC1),
But I am not able to understand why ENET on SCC2 disturbs USB at
all.

is there any solution without touching uart.c file ?

Best Regards,
_________________________________________________________
There is always a better job for you at Monsterindia.com.
Go now http://monsterindia.com/rediffin/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
