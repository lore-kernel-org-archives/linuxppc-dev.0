Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 16:40:23 +1100
Subject: [PATCH 0/11] ibm_newemac: Candidate patches for 2.6.25
Message-Id: <1196401223.5661.297518056501.qpush@grosgo>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are the patches I have pending for EMAC. With those, along with
some other powerpc patches scheduled for 2.6.25 for adding support
for those various boards, I have EMAC now working properly on a
variety of platforms, such as Taishan (440GX), Katmai (440SP),
EP405 (405GP), Bamboo (440EP), etc...

This serie apply on top of the patch:

"ibm_newemac: Fix possible lockup on close"

Which should be on its way to 2.6.24 already.
