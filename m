Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id A89E967B82
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jul 2006 04:45:52 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: sig 11 in hdlc_enet_rx
Date: Wed, 12 Jul 2006 20:46:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200607122046.05257.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm using the driver hdlc_enet.c in denx kernel 2.4.25 on a MPC880 using scc3. 
I disabled ARP that causes a lot of packet losses but from time to time I 
receive a kernel sig 11 in hdlc_enet_rx. I saw this behaviour when working 
with ENET_BIG_BUFFERS. During the night I'm doing some tests with SMALL 
BUFFERS. Anyone had the same problem?

Bye,
Antonio.
