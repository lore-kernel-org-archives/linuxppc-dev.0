Date: Wed, 17 Dec 2003 16:16:17 +0100
Message-Id: <HQ1P35$3B2DD599425FFFEED071BBE420BEE803@libero.it>
Subject: PPC 405 OCP EMAC MAL problem
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "l.lucrezia.tiesse@iol.it" <l.lucrezia.tiesse@iol.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have developped a board with NPE405 processor with PPC Linux 2.4.20 kernel, we also have reported various patchs to ibm_ocp device driver, but when we run a test that outputs via FTP big files of both ethernet interfaces contemporarly, we observe that there is a period (few seconds) in which we did not receive any data, then we get a RXDE interrupt and then we see a RXEOB interrupt pending on the MAL, CPU is not interrupted at all.....

Does somebody have any idea ?

thanks a lot


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
