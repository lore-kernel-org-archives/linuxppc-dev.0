Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsxfX0kVLzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 05:47:30 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Olof Johansson <olof@lixom.net>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sun, 17 Jul 2016 19:40:42 +0100 (BST)
Message-ID: <487fa010858.3ea76b1c@auth.smtp.1and1.co.uk>
Subject: [PATCH 0/1] pasemi: Add fixup_device_tree function to prom_init
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello All,

I'm currently working on some device tree patches for the AmigaOne X1000,
which I hope to push into the mainline kernel, however there is currently no
function for PASemi fixes, this patch introduces it. No code changes at 
this time.

This will be for 4.8 (if possible)

Kind regards
Darren
