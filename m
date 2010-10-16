Return-Path: <nab@linux-iscsi.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com (smtp126.sbc.mail.sp1.yahoo.com
	[69.147.65.185]) by ozlabs.org (Postfix) with SMTP id B42D9B70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Oct 2010 19:08:43 +1100 (EST)
Subject: 64K PAGE_SIZE and arch/powerpc/kernel/vdso.c
From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 Oct 2010 01:03:59 -0700
Message-Id: <1287216239.9909.234.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greetings Linux-ppc64 folks,

While trying to compile v2.6.36-rc8 with PAGE_SIZE=65536 I run into the
following compile failure w/ strict checking on a RHEL5.4 / gcc (GCC)
4.1.2 20080704 (Red Hat 4.1.2-46) system:

cc1: warnings being treated as errors
arch/powerpc/kernel/vdso.c:81: warning: alignment of ‘vdso_data_store’
is greater than maximum object file alignment.  Using 32768
  CC      arch/powerpc/sysdev/msi_bitmap.o
make[1]: *** [arch/powerpc/kernel/vdso.o] Error 1
make[1]: *** Waiting for unfinished jobs....

Any ideas folks..?

TIA,

--nab
