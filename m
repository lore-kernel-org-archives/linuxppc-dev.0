Message-Id: <200401041555.JAA03904@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-2"
From: Samo Pogacnik <samo.pogacnik@s5.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: memory problem with fec on 8250
Date: Sun, 4 Jan 2004 16:55:31 +0100
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

Is it possible that there is something wrong in the way how the:
"netif_wake_queue(dev)" gets called from the interrupt handler in the
"fcc_enet.c"?
I can confirm this problem for 2.4.18 as well as 2.6.0 kernels on mpc82xx.

bye, Samo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
