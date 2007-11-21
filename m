Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Nov 2007 17:06:38 +1100
Subject: [PATCH 0/8] ibm_newemac: Candidate patches for 2.6.25
Message-Id: <1195625198.76200.922309668615.qpush@grosgo>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are the patches I have pending for EMAC. With some non-released
patches from Hugh Blemings, I get a taishan (440GX) booting now,
in addition to Ebony (440GP) and various 405GP boards.

This is 2.6.25 material except for patch #1 which has already been
posted separately and is candidate for 2.6.24 (and possibly stable)
