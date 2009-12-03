Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 4EAFCB7BDF
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 10:31:03 +1100 (EST)
Date: Fri, 4 Dec 2009 02:30:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 0/4] systemtap: Some more powerpc patches
Message-ID: <20091203233059.GA28186@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Jim Keniston <jkenisto@us.ibm.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Here are few more patches for systemtap/powerpc...

- Patches 1-3 are used to fix failing tests as reported by
  testsuite/systemtap.context/num_args (thanks to Jim Keniston for
  the hint);

- Fourth patch just improves backtrace output. Though, backtrace.stp
  test is still failing, I'm currently investigating this.

..I need set up a bit faster machine to run the whole testsuite
(just one test takes ages to complete on a diskless 300 MHz board ;-),
and when I set it up I'll post the results.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
