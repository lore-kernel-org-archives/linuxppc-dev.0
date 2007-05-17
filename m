Return-Path: <lichl@hotmail.com>
Received: from bay0-omc2-s9.bay0.hotmail.com (bay0-omc2-s9.bay0.hotmail.com
	[65.54.246.145]) by ozlabs.org (Postfix) with ESMTP id 31570DDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 17:28:43 +1000 (EST)
Message-ID: <BAY124-W4059668EE4BB8933289F97AD330@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_e975f141-23bb-4235-9f88-c1060d6a7cbc_"
From: liChunlin <lichl@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Down when i get date from rtc by "hwclock --hctosys" 
Date: Thu, 17 May 2007 15:28:39 +0800
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_e975f141-23bb-4235-9f88-c1060d6a7cbc_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit

The system is Embeded Linux with kernel 2.6.14. And the CPU is MPC8270 of freescale. The rtc module is "Generic /dev/rtc emulation" and "Extended RTC operation". And the chip of rtc is ds1338 with the interface of i2c. The module of i2c has been included.
When i enable the dcache of mpc8270 and use "hwclock --hctosys" or "hwclock --show", the system will down. But if i disable dcache, it is ok. I found that when it call schedule_work(&genrtc_task) in the function "static inline int gen_set_rtc_irq_bit(unsigned char bit)" in file genrtc.c it will down.
Can you help me? 
Thanks.Leo
_________________________________________________________________
中国十大热门旅游景点
http://search.msn.com/results.aspx?q=%E4%B8%AD%E5%9B%BD%E5%8D%81%E5%A4%A7%E9%A3%8E%E6%99%AF&mkt=zh-CN&form=QBRE
--_e975f141-23bb-4235-9f88-c1060d6a7cbc_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
P
{
margin:0px;
padding:0px
}
body
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body>The system is Embeded Linux with kernel 2.6.14. And the CPU is MPC8270 of freescale. The rtc module is "Generic /dev/rtc emulation" and "Extended RTC operation". And the chip of rtc is ds1338 with the interface of i2c. The module of i2c has been included.<BR>
When i enable the dcache of mpc8270 and use "hwclock --hctosys" or "hwclock --show", the system will down. But if i disable dcache, it is ok. <BR>I found that when it call schedule_work(&amp;genrtc_task) in the function "static inline int gen_set_rtc_irq_bit(unsigned char bit)" in file genrtc.c it will down.<BR>
Can you help me? <BR>
Thanks.<BR>Leo<BR><BR><br /><hr />中国十大热门旅游景点 <a href='http://search.msn.com/results.aspx?q=%E4%B8%AD%E5%9B%BD%E5%8D%81%E5%A4%A7%E9%A3%8E%E6%99%AF&mkt=zh-CN&form=QBRE' target='_new'>了解更多信息！</a></body>
</html>
--_e975f141-23bb-4235-9f88-c1060d6a7cbc_--
