From: rayson_ho@hongkong.com
Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <gM988793884351.18059@mail1.hongkong.com>
Date: Thu, 6 Dec 2001 11:56:48 +0800 (CST)
To: linuxppc-dev@lists.linuxppc.org
Cc: 
Subject: fetch_and_add() available on PPC Linux?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am porting a threads library to PPC Linux... Since some applications depend on it, I can't easily switch to pthreads.

The library uses fetch_and_add(), which is available on AIX. I tried to compile it on PPC Linux, but failed to link.

I compiled the code on AIX with -S. Then I examined the assembly listing, and found that fetch_and_add() is a lib/OS call.

I would like to know if PPC Linux has something similar to fetch_and_add() on AIX, if not, are there any workarounds??

Thanks,
Rayson



----------------------------------------------
 歡迎使用HongKong.com郵件系統
 Thank you for using hongkong.com Email system


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
