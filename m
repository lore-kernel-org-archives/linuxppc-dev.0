Message-Id: <200109200828.QAA15692@isdn.iscas.ac.cn>
Date: Thu, 20 Sep 2001 16:29:30 +0800
From: weiwu <weiwu@isdn.iscas.ac.cn>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Prblem of wirting with char module in mtd
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:
    I am trying to get flash board with mtd.
At the beginning I use it as a char module,but
I found there are some stranges in writing.

   1 It print "waiting for chip to be ready
timed out in bufwrite and so on" once in a while.
I found the scripts of it is notnecessary,
so I cancel  it.
   I wanna know the function of it.

   2 During writing ,I print the message of writing
and the value of writing address,it is OK!But when
I read the flash,I found the wrting is failed.
   I don not know why?

   3  I don not know how to erase the flash,and I wang to
use jffson into mtd.who can tell me the  step and the notice.

I work with an custom board MPC823 kernel 2.2.14.
The flash is Intel 28f320j5

            weiwu
            weiwu@isdn.iscas.ac.cn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
