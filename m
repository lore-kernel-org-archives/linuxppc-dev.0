Message-ID: <013e01c3db2c$627dee50$21589edd@CHKIMVAIO>
From: "???" <willy@airpoint.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <001101c3dacc$c5e182a0$7200a8c0@internal.momenco.com>
Subject: basic kernel can call the function pointer of loadable kernel module?
Date: Thu, 15 Jan 2004 14:56:56 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am not sure it's the right thing to ask you some questions
about kernel module programming. Bur according to the
book 'The Linux Kernel Module Programming Guide' in
www.ibiblio.org/pub/Linux/docs/linux-doc-projext/module-programming-guid
e, I have some questions.

In chapter 14, I found followings.

 Using standard libraries

 You can't do that. In a kernel module you can only use kernel
functions, which are the functions you can see in /proc/ksyms.

 My question is that the basic kernel can execute the function pointer
of loaded module? For example, a loaded kernel module passes its
funciton pointer to ethernet driver(I have done this). But the system
hangs when ethernet driver calls that pointer. Is it possible the basic
kernel to call the function pointer of a loaded module?

 willy in a little bit confused.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
