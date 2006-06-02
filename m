Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 5776967B24
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 19:20:52 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: MPC880 cannot use SCC4 together with FECs
Date: Fri, 2 Jun 2006 11:21:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606021121.57625.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a question for a Freescale guy or anyone that already used the MPC880.
I'm using an MPC880, both the FECs are used and SMC1, SMC2 and SCC3 are 
currently being used too. Now I need to use the SCC4 as an asynchronous 
serial port (only two pins) but my hardware engineer is saying that is not 
possible because pins are missing. I cannot believe this, they told me that 
RXD4 could use pins: PA11 or PD8 or PE25 but actually PA11 is used by the 
first FEC for MII1-TXD0,
PD8 for MDC and PE25 for second FEC MII2-TXD3.

Is this correct?

Bye,
Antonio.
 
