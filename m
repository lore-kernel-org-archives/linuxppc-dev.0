MIME-Version: 1.0
Message-Id: <396D8712.26614@mta5>
Date: Thu, 13 Jul 2000 17:08:34 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Local sdram in 8260 board
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



      Hi,I try to make 60x sdram and the local sdram a continuous
20M ram area to accommodate a 8M ramdisk in the motorola 8260 ads board.When it load the initrd,it will get machine check exception
at address 0x1000004 which is in the local sdram.When i disable the
cache ,it will work. Does local sdram noncacheble?How should i
fix it?

davidzhang
7/13/2000


_____________________________________________
一路上有你，苦一点也愿意！
--为你喜爱与支持的263首都在线（http://www.263.net）投一票！
我要投票！（http://fsurvey.cnnic.net.cn/survey/index.html）

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
