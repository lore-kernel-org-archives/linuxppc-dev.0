Return-Path: <dagriego@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id 7FA1CDDEA3
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 05:27:20 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so1345369nzf
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Apr 2007 12:27:18 -0700 (PDT)
Message-ID: <3d42041d0704091227s2a3d6ad1pb6d5e0dbcbac375f@mail.gmail.com>
Date: Mon, 9 Apr 2007 12:27:18 -0700
From: dagriego <dagriego@gmail.com>
To: galak@kernel.crashing.org
Subject: Remove arch/powerpc/platforms/85xx/mpc8540_ads.h
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,
I'm looking at adding a platform based on the mpc8540ads and came across the
arch/powerpc/platforms/85xx/mpc8540_ads.h.  Is this file still needed
for something?  If not, should I create a patch to have it removed
from the tree?
Thanks,
-David
