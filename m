Return-Path: <zengshuai@sogou.com>
Received: from sogoumx75.mail.sogou.com (unknown [61.135.132.136])
	by ozlabs.org (Postfix) with ESMTP id EA93668880
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Dec 2005 00:21:58 +1100 (EST)
Received: from mx3.mail.sohu.com (unknown [192.168.95.78])
	by sogoumx75.mail.sogou.com (Postfix) with ESMTP id D0EC40656DB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 20:51:23 +0800 (CST)
Message-ID: <18160795.1134650325274.JavaMail.postfix@mx3.mail.sohu.com>
Date: Thu, 15 Dec 2005 20:38:45 +0800 (CST)
From: <zengshuai@sogou.com>
To: "ppc" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Subject: help needed:Which file is the key file in the ELF(for linux) linker?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

//hello.c
int main()
{
    int a;
    a=1;
}
--------------------------
first time:
#gcc -c -o hello.o hello.c
#ld -o hello.elf hello.o
#file hello.elf
hello.elf: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV),
statically inked, not stripped                                                            

second time:
#gcc -c -o hello.o hello.c
#ld -static hello.o /usr/lib/crt1.o /usr/lib/crti.o /usr/
ib/crtn.o /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/crtbegin.o /usr/lib/gcc-lib/
386-redhat-linux/3.2.2/crtend.o -L/usr/lib -lc /usr/lib/gcc-lib/i386-redhat-lin
x/3.2.2/libgcc.a -o hello.elf                                                   
#file hello.elf
hello.elf: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), 
for GNU/Linx 2.2.5, statically linked, not stripped                                       
~~~~~~~~~~~~~~~~~~

So,which file is the key file,which cause the change,from elf to linux elf?
How to compile a ELF file using in bareboard and how to compile a ELF file 
using in Linux really puzzles me a lot.thanks

------------------------------
我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=linuxppc-embedded&FullName=linuxppc-embedded&Email=linuxppc-embedded%40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
