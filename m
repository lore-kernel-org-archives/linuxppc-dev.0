Message-Id: <200309192258.h8JMwWs04059@mail.osdl.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.6.0-test5 "incorrect section attributes for .plt"
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Sep 2003 15:58:32 -0700
From: Cliff White <cliffw@osdl.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


System is an iBook2,
distro is Debian unstable
kernel is 2.6.0-test5 or current from
bk://ppc.bkbits.net/linuxppc-2.5

gcc version 3.3.2 20030908 (Debian prerelease)

When compiling modules, i get this warning, repeatedly:
 CC [M]  sound/ppc/pmac.o
{standard input}: Assembler messages:
{standard input}:3: Warning: setting incorrect section attributes for .plt

Then, this failure:

  AS      arch/ppc/boot/common//util.o
arch/ppc/boot/common/util.S: Assembler messages:
arch/ppc/boot/common/util.S:220: Warning: setting incorrect section attributes
for .relocate_code
arch/ppc/boot/common//util.o: File truncated
arch/ppc/boot/common/util.S:281: FATAL: Can't write
arch/ppc/boot/common//util.o: File truncated
make[2]: *** [arch/ppc/boot/common//util.o] Error 1
make[1]: *** [arch/ppc/boot/common/] Error 2

Suggestions appreciated, please cc me as i am not subscribed to this list.
cliffw
cliffw@osdl.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
