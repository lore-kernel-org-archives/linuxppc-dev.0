Return-Path: <gqbenjamin@21cn.com>
Received: from 21cn.com (send.forptr.21cn.com [202.105.45.48])
	by ozlabs.org (Postfix) with SMTP id C0F5D67B65
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 17:47:01 +1000 (EST)
Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <PA949588846873.25549@webmail2.inner-21cn.com>
Date: Mon, 11 Apr 2005 15:31:26 +0800 (CST)
From: gqbenjamin@21cn.com
To: linuxppc-embedded@ozlabs.org <linuxppc-embedded@ozlabs.org>
Cc: gqben@sina.com
Subject: Ethernet on Linux for MPC8250
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,

i use *SmartBits* to test the Ethernet rate of mpc8250, kernel is linux-2.4.20 with CONFIG_FCC_LXT971 and CONFIG_USE_MDIO.

if *SmartBits*'s rate set too high, for example 100 Mbps Full Duplex, each packet is 1514 Bytes, the kernel print '... Memory squeeze, dropping packet.' on uart. 

later, stop *smartbits* and *cat /proc/meminfo*, the *MemFree* become small, try again, become smaller, look like the allocated memory do not be free.

finally the kernel break down, because all memory have been used.

Q. how can i do to let kernel do not break down? this problem is kernel's promblem?

i use linux-2.6.5 for mpc8250 to test, and get the same result.

have a nice day.

----------------------------------------------
21CN邮箱全面升G 
http://mail.21cn.com/huodong/0504/mail/ 
彩屏手机白送啦!赶快来拿! 
http://qipai.g.21cn.com 
智慧大挑战就在低价夺宝 
http://super.21cn.com/ 
体验另类约会，感受别样浪漫 
http://y.21cn.com/club/ 
小灵通短信中心，短信魅力无极 
http://pas.21cn.com/ 
全能聊2005版闪亮登场！ 
http://callme.21cn.com 




----------------------------------------------
21CN邮箱全面升G 
http://mail.21cn.com/huodong/0504/mail/ 
彩屏手机白送啦!赶快来拿! 
http://qipai.g.21cn.com 
智慧大挑战就在低价夺宝 
http://super.21cn.com/ 
体验另类约会，感受别样浪漫 
http://y.21cn.com/club/ 
小灵通短信中心，短信魅力无极 
http://pas.21cn.com/ 
全能聊2005版闪亮登场！ 
http://callme.21cn.com 
