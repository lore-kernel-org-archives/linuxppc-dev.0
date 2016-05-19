Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x242.google.com (mail-ig0-x242.google.com
 [IPv6:2607:f8b0:4001:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Gz12TxFzDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:39:41 +1000 (AEST)
Received: by mail-ig0-x242.google.com with SMTP id c3so6368907igl.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 20:39:41 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 0/4] rcutorture: Several fixes to run selftest scripts on PPC
Date: Thu, 19 May 2016 11:42:20 +0800
Message-Id: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I spend some time to make tools/testing/selftest/rcutorture run on PPC,
here are some documention and fixes made while I was trying.

The scripts are able to run and get results on PPC, however please
note there are some stalls even build errors that could be found
by the tests currently.

As I'm certainly not an expert of qemu or bash programming, there
may be something I am missing in those patches. So tests and comments
are welcome ;-)

Regards,
Boqun

Boqun Feng (4):
  rcutorture/doc: Add a new way to create initrd using dracut
  rcutorture: Use vmlinux as the fallback kernel image
  rcutorture: Make -soundhw a x86 specific option
  rcutorture: Don't specify the cpu type of QEMU on PPC

 .../testing/selftests/rcutorture/bin/functions.sh  | 13 ++++++-------
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     | 13 +++++++------
 tools/testing/selftests/rcutorture/doc/initrd.txt  | 22 ++++++++++++++++++++++
 3 files changed, 35 insertions(+), 13 deletions(-)

-- 
2.8.0
