Message-ID: <001801c21129$93ffa050$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: real time clock seems stuck!
Date: Tue, 11 Jun 2002 17:22:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sir,
      I use SMC2 for Console,this time message come from SMC2,but it has warning message like following:
warning: Real time clock seems stuck, then it is dead!
it seems calibrate_delay() function can not go forward(perhaps), Do you know why? Should I add CONFIG_RTC?
it looks like jiffies can not be updated. Do you have some good idea for this.do not forget send your
.config for me.thank you again.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
