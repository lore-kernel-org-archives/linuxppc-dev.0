Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 489BFDDF22
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 19:20:25 +1100 (EST)
Date: Wed, 05 Mar 2008 17:20:00 +0900 (JST)
Message-Id: <20080305.172000.-1300537299.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 0/11] celleb: patchset for 2.6.26
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a patchset for 2.6.26 which contains following changes:

- cleanup                                 [PATCH 1/11]
- move celleb files into platforms/cell/  [PATCH 2/11]..[PATCH 7/11]
- consolidate io-workarounds code         [PATCH 8/11]..[PATCH 9/11]
- add support for celleb PCI Express      [PATCH 10/11]
- bug fix                                 [PATCH 11/11]

Consolidating io-workarounds code changes the code to support
CellBlade PCI. Please test it because I don't have any access to
CellBlade.

Best regards,
Kou Ishizaki
