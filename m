Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 064B42C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 17:04:47 +1000 (EST)
Message-ID: <51ECD91D.7090903@asianux.com>
Date: Mon, 22 Jul 2013 15:02:53 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>
Subject: [Suggestion] powerpc: xmon: about 'longjmp' related warning.
Content-Type: text/plain; charset=windows-1252
Cc: Michael Neuling <mikey@neuling.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>, jovi.zhangwei@huawei.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Maintainers:

With allmodconfig and EXTRA_CFLAGS=-W", it reports warnings below:

arch/powerpc/xmon/xmon.c:3027:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
arch/powerpc/xmon/xmon.c:3068:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
arch/powerpc/xmon/xmon.c:352:48: warning: argument ‘fromipi’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]

Excuse me, I am not quite sure about it whether can cause issue or not.

Welcome any members' suggestions or completions for it.


Thanks.
-- 
Chen Gang
