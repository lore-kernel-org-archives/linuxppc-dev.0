Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 95852DDF19
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 22:23:05 +1000 (EST)
Date: Wed, 6 Aug 2008 14:23:01 +0200
From: Olaf Hering <olaf@aepfle.de>
To: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: unconditional link object arch/powerpc/lib/crtsavres.o breaks
	module build
Message-ID: <20080806122301.GA27495@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sam,

please have a look at bug 11143.
http://bugzilla.kernel.org/show_bug.cgi?id=11143


arch/powerpc/lib/crtsavres.o is added inconditionally to the linker
flags, but there is no rule to actually create the object file.
This breaks building external modules on 32bit powerpc since 2.6.26.

Thanks,
Olaf
