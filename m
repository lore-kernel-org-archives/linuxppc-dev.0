Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56728DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 12:20:16 +1100 (EST)
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id n231Jm0h002134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Mar 2009 17:19:49 -0800
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id
	n231Jmqh010837
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Mar 2009 17:19:48 -0800
Date: Mon, 2 Mar 2009 17:19:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc allnoconfig
Message-Id: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


make mrproper
make allnoconfig
make vmlinux

gives:

scripts/kconfig/conf -s arch/powerpc/Kconfig
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-powerpc
  HOSTCC  scripts/ihex2fw
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
scripts/mod/empty.c:1: error: -m64 requires a PowerPC64 cpu
make[2]: *** [scripts/mod/empty.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/mod] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [scripts] Error 2
