From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AFD3F8F.24773@bjapp4>
Date: Sat, 12 May 2001 21:50:07 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Why panic when run /bin/init?
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all,
    I have added a lcd device driver into my kernel,but when it run at /bin/init it panic . If I note the /bin/init in main.c,it works well(i add
 /proc filesystem manualy).Sometimes it can execute /bin/init in main.c(such as
i reduce some code in my driver).
   I use HHL2.2.14 & MPC850 & NFS root files.
   Who can help me? thx.

Dross Chou.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
