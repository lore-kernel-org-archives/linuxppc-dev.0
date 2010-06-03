Return-Path: <linuxuser330250@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B314AB7D43
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Jun 2010 01:08:41 +1000 (EST)
From: "Linux User #330250" <linuxuser330250@gmx.net>
To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Subject: Compilation error: KVM support for PowerPC book3s_64 processors
Date: Thu, 3 Jun 2010 16:10:06 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201006031610.06459.linuxuser330250@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

My hardware: Apple Power Mac G5 "Late 2005"

I've just compiled kernel 2.6.34 for Gentoo Linux.
# ACCEPT_KEYWORDS=3D"~ppc64" emerge -1 sys-kernel/gentoo-sources-2.6.34

I tried the "KVM support for PowerPC book3s_64 processors" just to see if w=
hat=20
I could do with KVM on my Apple Power Mac G5 with IBM PowerPC 970MP process=
or.=20
Apperently it isn't supported by this CPU. Or am I wrong?

Anyway, I get errors that indicate this option requires some VSX support,=20
which isn't supported by IBM POWER4+/PowerPC G5. I cannot post the complete=
=20
error message right now, but maybe some of you can try it.

Processor support  --->
[*] AltiVec Support
[ ]   VSX Support

[*] Virtualization  --->
<*>   KVM support for PowerPC book3s_64 processors

Some maybe relevant .config options:
CONFIG_PPC_BOOK3S_64=3Dy
CONFIG_PPC_BOOK3S=3Dy
CONFIG_POWER4_ONLY=3Dy
CONFIG_POWER4=3Dy
CONFIG_PPC_FPU=3Dy
CONFIG_ALTIVEC=3Dy
=E2=80=A6
CONFIG_PPC_PMAC=3Dy
CONFIG_PPC_PMAC64=3Dy
=E2=80=A6
CONFIG_KVM_MMIO=3Dy
CONFIG_VIRTUALIZATION=3Dy
CONFIG_KVM=3Dy
CONFIG_KVM_BOOK3S_64_HANDLER=3Dy
CONFIG_KVM_BOOK3S_64=3Dy


Maybe I've got something wrong though=E2=80=A6 Or there are other dependenc=
ies, like=20
CONFIG_VSX that are not met.


Let me know if I can help to test something.
Cheers,
Andreas.
