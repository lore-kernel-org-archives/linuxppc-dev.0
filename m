Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F1CFDDF4D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:51:08 +1100 (EST)
Date: Fri, 12 Jan 2007 09:51:03 +0900 (JST)
Message-Id: <200701120051.l0C0p3Xu017082@toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 0/19] Patches for Toshiba Cell reference set
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

Paul-san,

This is a revised version of the patch set for Toshiba Cell reference
set (aka Celleb).

Patch 1-3 are generic for Cell and not dependent on any other patches.
I think that they are useful for other platforms. Patch 4-19 are to
support for Celleb.

This patch set is intended to be merged to 2.6.21.
If you have any comment, please write to me.

Best regards,
Kou Ishizaki
Toshiba
