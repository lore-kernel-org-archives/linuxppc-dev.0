Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15803.mail.cnb.yahoo.com (web15803.mail.cnb.yahoo.com
	[202.165.102.83]) by ozlabs.org (Postfix) with SMTP id 6D323683B2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 22:42:23 +1000 (EST)
Message-ID: <20050929123535.66570.qmail@web15803.mail.cnb.yahoo.com>
Date: Thu, 29 Sep 2005 20:35:35 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: Available user-level tool for I2C device?
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

I'd like to ask whether there is user-level utility
for I2C device registers access like lspci/setpci for
PCI device?

I have a RTC chip DS1337 on a 8248 target. It can
work right in u-boot and linux. If no similar utility,
I will switch to change hwclock.c in busybox to make
it. Any idea?

Thanks in advance,

Sam

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
