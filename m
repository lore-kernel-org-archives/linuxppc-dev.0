From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3BB9BC07.14257@bjapp3>
Date: Tue, 2 Oct 2001 21:07:19 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: =?gb2312?B?SG93IHRvIHVzZSBzb2Z0IHJlYWwtdGltZQ==?=
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,
     In our project,we must write  driver for a device which generates interrupts about 2000 times per second,the service application must
send about 300kB/s data(from device) into network(using UDP).We want to use soft real time in the interrupts in order to response device quickly, how to do?
     In addition ,how to use high priority in our service application ?
     We use a custom 860 borad and hhl2.0.

Chang Zhou







===============================================

手机号码是电邮，从此交费不用愁，一号在手“随身邮”

—— 163“随身邮”手机邮箱 ——
◎ 手机号码就是电子邮箱地址，方便记忆
◎ 不用上网，透过手机短信，随时掌握邮件的接收情况
◎ 决不错过任何商业良机
◎ 方便的按月收费方式，最低每月只需5元

详情请浏览
http://vip.163.net/mobile/mobile.htm

===============================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
