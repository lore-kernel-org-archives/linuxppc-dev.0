MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: What is the version RTLinux and its corresponding version of Linux can support 8260?
Date: Sat, 31 Mar 2001 11:43:30 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E310A9129@kolkrabbi.flaga.is>
From: =?Windows-1252?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "machael" <dony.he@huawei.com.cn>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I do not know enough of 8260, nor RT-linux, but you seem to
be using the kernel from kernel.org. Even though it is the
official kernel for most people (read Intel people). There are
some deviations from the kernel that ppc
people use. Try to download the kernel from fsmlabs.com.
I believe that the fsmlabs kernels stay in sync with the the
offical kernel from kernel.org while not all changes from the
ppc folks makes it into the official kernel.

I believe that they (fsmlabs) are also the people makeing
rt-linux so you might have much better luck there.

Hope this helps,

K.D.


-----Original Message-----
From:	machael
Sent:	Fri 3/2/2001 2:22 AM
To:	linuxppc-embedded@lists.linuxppc.org; rtl@rtlinux.org
Cc:
Subject:	What is the version RTLinux and its corresponding
version of Linux can support 8260?


Hello,

     I want to use RTLinux for my 8260-based custom board and meet some
difficulties.  I have asked  rtl@rtlinux.org , but no one seems to be
able
to help me. So I  put my messages here.
I am very sorry if this may disturb you.
    Now I can run linux-2.4.1  linux-2.4.2 and linux-2.4.3-pre4 on my
8260-based custom board  and neither of these versions can work
successfully
with RTLinux-3.0(because I have tried them). Does RTLinux-3.0 support
8260
CPU now? If so, What is the version of RTLinux and where can I download
it?
And its corresponding LINUX version  and where can I download it?

Someone said rtlinux3.0v2.4.2 can work with linux-2.4.2 and it supports
8260. So I try to use rtllinux3.0v2.4.2  from
ftp.fsmlabs.com/pub/v3/linux-v242 ,and linuxkernel2.4.2 from
www.kernel.org,
but when I compile rtlinux-3.0 (for ppc kernel),  it reports no "__cli"
and
"__cli_end"  etc...


Anyone who has some experience can help me?

Thank you very much.

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
