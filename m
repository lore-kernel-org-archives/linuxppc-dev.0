Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id ADF63B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Sep 2010 04:34:44 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0 (Apple Message framework v1081)
Subject: kexec on ppc64
From: Matthew McClintock <msm@freescale.com>
Date: Tue, 7 Sep 2010 13:34:24 -0500
Message-ID: <0D324CAF-2A5D-4363-9000-7EB48179C11C@freescale.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

I'm trying to determine how kexec'ing works on 64 bit powerpc. When =
allocating a region for the kexec'ed kernel is it ever the same as the =
currently running kernel or do you always boot the kexec'ed kernel from =
a different memory region? I understand that a crash kernel will be in a =
different region, however I was hoping to confirm the behavior for a =
normal "kexec -e".

Thanks,
Matthew=
