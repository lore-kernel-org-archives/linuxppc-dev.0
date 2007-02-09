Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 777D3DDEE6
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 03:59:49 +1100 (EST)
Message-ID: <45CCA537.9010801@am.sony.com>
Date: Fri, 09 Feb 2007 08:45:43 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] ps3: missing exports
References: <E1HFYFb-0004rm-0y@ZenIV.linux.org.uk>
In-Reply-To: <E1HFYFb-0004rm-0y@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Al Viro wrote:
---
 arch/powerpc/platforms/ps3/interrupt.c  |    2 ++
 arch/powerpc/platforms/ps3/system-bus.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)


Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
