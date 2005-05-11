Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15806.mail.cnb.yahoo.com (web15806.mail.cnb.yahoo.com
	[202.165.102.86]) by ozlabs.org (Postfix) with SMTP id D5F11679F6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 23:05:29 +1000 (EST)
Message-ID: <20050511130526.71024.qmail@web15806.mail.cnb.yahoo.com>
Date: Wed, 11 May 2005 21:05:26 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: 2.6.12-rc2 : i2c-mpc - failed to attach interrupt
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Sth unexpected happened when I enabled MPC107 I2C bus
support on a MPC8241 board. The slave device DS1337 
couldn't work at all. Any hints? 

......
i2c /dev entries driver
i2c-mpc - failed to attach interrupt
iic: probe of 00 failed with error -38
---ds1337 driver registering---
......
bash-2.05b# cat /proc/driver/rtc
rtc_time        : 00:00:-19
rtc_date        : 1970-01-01
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no
periodic_IRQ    : no
periodic_freq   : 0
batt_status     : okay
bash-2.05b# date
Wed Dec 31 19:05:23 EST 1969
bash-2.05b#

Thanks in advance,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
