Message-ID: <001701c09f91$6f2d7be0$8021690a@huawei.com>
From: "dony" <dony.he@huawei.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "CrossGCC" <crossgcc@sourceware.cygnus.com>
Subject: powerpc-linux-gcc compiler error: undefine reference to "__va_arg_type_violation"
Date: Mon, 26 Feb 2001 09:14:14 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    When I compile my kernel , it reports in vsprintf:
    Undefined reference to "__va_arg_type_violation".

My cross environment is:
 gcc-2.95.2
 glibc-2.1.2
 binutils-2.9.5.0.22
 gcc-core-2.95.2

But when I use the following environment , It can build my kernel sucessfully:

binutils-2.9.1.0.19a
egcs-core-1.1.2.tar.gz
glibc-2.1.tar.gz

Does anybody know why?

TIA
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
