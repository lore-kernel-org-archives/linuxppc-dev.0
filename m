Message-ID: <290845089.25401@eyou.com>
Date: 26 Jul 2004 20:31:28 +0800
Message-ID: <20040726203128.92531.qmail@eyou.com>
From: "lig" <iceberg_horn@eyou.com>
To: sjhill@realitydiluted.com
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: "lig" <iceberg_horn@eyou.com>
Subject: Re:64360&nbsp;serial&nbsp;driver&nbsp;for&nbsp;2.6....
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can try to change the macro XXX_SERIAL_1_ADDR and XXX_SERIAL_2_ADDR. The
value of XXX_SERIAL_1_ADDR is 0xef600008 and the value of XXX_SERIAL_2_ADDR is
0xef600000.
>
>Greetings.
>
>I see that a few people are working with the 64x60 chips
>from Marvell. Has anyone ported the serial driver from 2.4
>into 2.6 yet? I have the 2.4 code and have ported the
>serial console code to 2.6 just fine, but I would rather
>not waste my time porting the serial driver proper if
>someone else has done it already. Please CC: me on the
>reply as I cannot subscribe to any of the PPC lists, even
>after multiple attempts.
>
>-Steve
>
>
>





--http://www.eyou.com
--稳定可靠的电子信箱  语音邮件  移动书签  日历服务  网络存储...亿邮未尽

--http://vip.eyou.com
--快快登录亿邮VIP信箱  注册您中意的用户名


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
