Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 3990ADDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 08:00:36 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so523928uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 13:00:34 -0800 (PST)
Message-Id: <20080227205831.150784453@gmail.com>
Date: Wed, 27 Feb 2008 23:58:31 +0300
From: gorcunov@gmail.com
To: rth@twiddle.net, chris@zankel.net, jdike@addtoit.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dhowells@redhat.com,
	zippel@linux-m68k.org, geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org, takata@linux-m32r.org,
	linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org
Subject: [RFC 00/10] vmlinux.lds cleanup
Cc: gorcunov@gmail.com, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches is made in purpose to use PAGE_SIZE and THREAD_SIZE
macroses in vmlinux linker scripts as much as possible instead of numeric
constants. Please review.

        WARNING: the patches are UNTESTED COMPLETELY - I've no access to
        that architectures and errors is highly possible ;)

	If you have an ability to test this patches - please do it.
	What is most important on review - these macroses *must* be
	placed into appropriate places - check it please.

	ANY comments are welcome.

		- Cyrill -

-- 
