MIME-Version: 1.0
Message-Id: <39333333.13669@mta5>
Date: Tue, 30 May 2000 11:19:15 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Floating point in 8260
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I make a port to motorola 8260 ads based on 2.2 kernel.
Now i am sure the kernel is fuctional,because i can run a
simple program that fork process and write to stdout.
I use simple assembly to make system call and does not
use any c lib.
When i try to run bash,8260 loops inside FPunavailble
exception.The 2.2 kernel support 603 with a FP,but
how should i do with 603e.
>From this lists,i learned that someone else encounter
similar problem,they upgrade to a 8260 with FP.
I do not want to upgrade,how should i do?
Should i recompile the bash and c lib.How should i treat
float point.BTW,i have a apple G3,should i compile
these stuff on this machine?

 Best Regards.


_____________________________________________
一路上有你，苦一点也愿意！
--为你喜爱与支持的263首都在线（http://www.263.net）投一票！
我要投票！（http://fsurvey.cnnic.net.cn/survey/index.html）

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
