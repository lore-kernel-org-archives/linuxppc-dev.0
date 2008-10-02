Return-Path: <liu_lin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id D8A0CDE234
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Oct 2008 20:48:57 +1000 (EST)
Message-ID: <422942429.11977@tsinghua.org.cn>
From: "=?gb2312?B?wfXB1g==?=" <liu_lin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 02 Oct 2008 18:13:49 +0800
Subject: Build cross compile tool chain for PPC
Content-Type: text/plain
Reply-To: =?gb2312?B?wfXB1g==?= <liu_lin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, All,

I am a newby for ppc embedded linux. When trying to build the cross compiling tool
chain, I got some error message in making glibc (binutils and gcc are successfully
built).

Error message is:

{quote}
assert.c: In function ¡®__assert_fail¡¯:
assert.c:54: error: ¡®__libc_pthread_functions_init¡¯ undeclared (first use in
this function)
assert.c:54: error: (Each undeclared identifier is reported only once
assert.c:54: error: for each function it appears in.)
assert.c:54: warning: implicit declaration of function ¡®PTHFCT_CALL¡¯
assert.c:54: error: ¡®ptr_pthread_setcancelstate¡¯ undeclared (first use in this
function)
assert.c:54: warning: left-hand operand of comma expression has no effect
make[2]: ***
[/root/embedded_linux/ppc/build-tools/build-glibc/ppc-glibc/assert/assert.os]
Error 1
make[2]: Leaving directory
`/root/embedded_linux/ppc/build-tools/build-glibc/glibc-2.7/assert'
make[1]: *** [assert/subdir_lib] Error 2
make[1]: Leaving directory
`/root/embedded_linux/ppc/build-tools/build-glibc/glibc-2.7'
make: *** [all] Error 2

{quote}

My environments are:

kernel: 2.26.     25
gcc & powerpc-linux-gcc: 4.3.2
binutils:2.18
glibc:2.7, configured with  linuxthreads enabled and nptl disabled.

My question is which packages should be used to build the toolchain for kernel
2.26.25
? Am I choosing the right version of these packages? Where can I find such
information?

Thank you very much in advance for any hints or suggestions.

Best Regards.

Lin
