Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 11BF467BD4
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 14:41:14 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAH3fDKL018060
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:41:13 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAH3fDcs018036
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:41:13 +0900 (JST)
Message-ID: <455D2F50.5010701@am.sony.com>
Date: Thu, 16 Nov 2006 19:41:04 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/16] patches for 2.6.20
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Here is a second round of the patches I have queued for 2.6.20.  Several
from the last posting have been merged into powerpc.git.  Patches 1-15 have
already been posted to this list.  I tried to address everyone's comments
from the last posting.  No major changes were introduced.  Patch 16 is
new and adds ps3_defconfig.

For the convenience of anyone interested, I have put this patchset, plus
a some of the drivers under development here:

  http://67.117.136.164/pub/cell/

-Geoff
