Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <UY989079829689.04572@webmail1.inner-21cn.com>
Date: Thu, 20 Sep 2001 17:03:10 +0800 (CST)
From: "yah" <hay8888@21cn.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Subject: GNIC problem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all.
  I have a giga-NIC.I want it can work under powerpc.When I install its driver and run 'insmod e1000.o', it said:

sh-2.03# insmod e1000.o
e1000.o: unresolved symbol create_proc_entry
e1000.o: unresolved symbol __delay_R850239f9
e1000.o: unresolved symbol loops_per_jiffy
e1000.o: unresolved symbol strlen_R97255bdf
e1000.o: unresolved symbol remove_proc_entry_R5d7ec1de
e1000.o: unresolved symbol printk_Rdd132261

Somebody told me this indicates a problem with my installation of the linux kernel. So I compiled the kernel many times, but all fault. What's wrong?
  I use linuxppc_2_4 from penguinppc. And the giga-NIC can work well under Intel board.
  Any suggestion? Thanks in advance.

------------------------------------------------
想免受广告信的骚扰，请马上升级为21cn经济邮用户。
http://member.21cn.com/economy/upgrade.php
还有更便宜的吗？
http://adinfo.21cn.com/price/001.html
加入龙腾计划，与21cn齐飞。
http://www.21cn.com/21cnhtm/qy/index.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
