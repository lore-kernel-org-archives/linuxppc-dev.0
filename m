Message-ID: <006f01c45533$21e7d0f0$2700000a@jmartin>
From: "jmartin" <jmartin@prodys.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc8xx idma
Date: Fri, 18 Jun 2004 14:52:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,

    i'm using a montavista kernel 2.4.20. We program a dsp device driver
which uses idma. Fec uses dma. Sympthoms are next:

system work perfect while device dma driver isn't active.
when active device, starts idma, and system hang

i think problem is fec sdma and idma working simultaneously. Exists any
problem if sdma and idma are working together?

thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
