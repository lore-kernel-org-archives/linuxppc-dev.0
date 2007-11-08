Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 08 Nov 2007 19:06:57 +1100
Subject: [PATCH 0/6] ibm_newemac: Pending patches for review
Message-Id: <1194509217.421165.545980042680.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are the patches I have pending for EMAC. With those and some not
yet released patches from Hugh Blemings to port Taishan support to
arch/powerpc, I get the board booting.

There's a question about the RGMII/MDIO thingy & sequoia, somebody
who knows that board should reply.
