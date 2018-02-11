Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfYn90qwVzF0gN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 03:15:38 +1100 (AEDT)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Date: Sun, 11 Feb 2018 17:15:30 +0100
Subject: KVM compile error
Message-Id: <064C3590-DCF8-4764-B0A4-B49310F1AF89@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just for info: KVM doesn=E2=80=99t compile currently.

Error messages:

CC      arch/powerpc/kvm/powerpc.o
arch/powerpc/kvm/powerpc.c: In function 'kvm_arch_vcpu_ioctl_run':
arch/powerpc/kvm/powerpc.c:1611:1: error: label 'out' defined but not used [=
-Werror=3Dunused-label]
 out:
 ^
cc1: all warnings being treated as errors

=E2=80=94 Christian=
