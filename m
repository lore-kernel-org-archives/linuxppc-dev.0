Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdm2029wgzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 07:52:56 +1100 (AEDT)
Date: Thu, 9 Mar 2017 07:52:49 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: kernel versions
Message-ID: <20170308205249.GA1257@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently the kernel version on the github
repository did not match up with the master branch of

https://kernel.googlesource.com/pub/scm/linux/kernel/git/powerpc/linux

Specifically, github was hosting v4.10-rc5 while master had
v4.10-rc8. All the while Linus' mainline was at v4.11-rc1.

Was this an anomaly or is there a technical reason please? While
writing this I see that perhaps I should have checked the other
branches (fixes, next, test).

thanks,
Tobin.
