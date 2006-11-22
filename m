Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail7-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4A45167C03
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 15:19:49 +1100 (EST)
Message-ID: <4563CFDB.3050709@am.sony.com>
Date: Tue, 21 Nov 2006 20:19:39 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/14] patches for 2.6.20
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

Here is the third round of the patches I have queued for 2.6.20.  Several
from the last posting have been merged into powerpc.git.  All patches have
already been posted to this list.  No major functional changes and only a
few minor functional changes were introduced in this set.  The main change
was to rename the platform from ps3pf to ps3.  I tried to address everyone's
comments from all previous postings.  I feel there are no outstanding issues.

For the convenience of anyone interested, I have put this patchset, plus
a some of the PS3 drivers under development here:

  http://67.117.136.164/pub/cell/

-Geoff
