From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH and RFC] Remove request_8xxirq
Date: Sun, 23 Jun 2002 18:54:43 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJCEOKCFAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <15635.16331.965632.877856@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

why not simply placing a new request_cascaded_irq() with an additional
controller/device identifier beside request_irq().

If you map the functionality to the original functions the rest of the code
could stay unchanged.
You can even map the old function calls using macros.
(If you like to you can use device 0 for a virtual mapping too. But I
wouldn't. :)

request_irq() could be left unchanged and new patches could use a single
registration function. So everyone should stay happy.

Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
