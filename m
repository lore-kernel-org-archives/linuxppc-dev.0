Message-ID: <20040504063215.79304.qmail@web8202.mail.in.yahoo.com>
Date: Tue, 4 May 2004 07:32:15 +0100 (BST)
From: =?iso-8859-1?q?somshekar=20kadam?= <som_kadam@yahoo.co.in>
Subject: linuxppc 2.6.5 mpc8xx compilation
To: runet@innovsys.com
Cc: shchoi@airpoint.co.kr, linuxppc-embedded@lists.linuxppc.org,
	som_kadam@yahoo.co.in
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI ,

  Currently i am trying to compile linux-2.6.5 for
mpc8xx for MBX reference board ,,,
i have some compilation problems ,, i am not able to
figure what could be the problem ,, i am not sure
correct me if i am wrong , is ppc code is completely
available in linux-2.6.5 verision ,,

i dont get errors if i compile for other 7xx 8260 , it
compiles fine ,,,

i have the error messages like this


----------------------------------------------
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to
date.
  CHK     include/asm-ppc/offsets.h
  CHK     include/linux/compile.h
dnsdomainname: Unknown host
  CC      arch/ppc/syslib/m8xx_setup.o
arch/ppc/syslib/m8xx_setup.c:223:35: macro "mfmsr"
passed 1 arguments, but takes just 0
arch/ppc/syslib/m8xx_setup.c: In function
`m8xx_restart':
arch/ppc/syslib/m8xx_setup.c:223: error: `mfmsr'
undeclared (first use in this function)
arch/ppc/syslib/m8xx_setup.c:223: error: (Each
undeclared identifier is reported only once
arch/ppc/syslib/m8xx_setup.c:223: error: for each
function it appears in.)
arch/ppc/syslib/m8xx_setup.c:216: warning: unused
variable `msr'
make[1]: *** [arch/ppc/syslib/m8xx_setup.o] Error 1
make: *** [arch/ppc/syslib] Error 2
-------------------------------------------------


Thanks In Advance
Neelu



________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
