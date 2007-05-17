Return-Path: <li.chunlin@zte.com.cn>
Received: from mx4.zte.com.cn (unknown [202.103.147.155])
	by ozlabs.org (Postfix) with ESMTP id E8AB6DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 18:01:03 +1000 (EST)
Received: (from root@localhost) by mse2.zte.com.cn id l4H8KWJ1004263
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 16:20:32 +0800 (CST)
	(envelope-from li.chunlin@zte.com.cn)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
	by mse2.zte.com.cn with ESMTP id l4H7uF61000960
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 15:56:15 +0800 (CST)
	(envelope-from li.chunlin@zte.com.cn)
Message-Id: <200705170820.l4H8KWJ1004263@mse2.zte.com.cn>
To: linuxppc-embedded@ozlabs.org
Subject: Down when i get date from rtc by "hwclock --hctosys" 
MIME-Version: 1.0
From: li.chunlin@zte.com.cn
Date: Thu, 17 May 2007 15:25:56 +0800
Content-Type: multipart/alternative;
	boundary="=_alternative 0028C317482572DE_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0028C317482572DE_=
Content-Type: text/plain; charset="US-ASCII"

The system is Embeded Linux with kernel 2.6.14. And the CPU is MPC8270 of 
freescale. The rtc module is "Generic /dev/rtc emulation" and "Extended 
RTC operation". And the chip of rtc is ds1338 with the interface of i2c. 
The module of i2c has been included.

When i enable the dcache of mpc8270 and use "hwclock --hctosys" or 
"hwclock --show", the system will down. But if i disable dcache, it is ok. 

I found that when it call schedule_work(&genrtc_task) in the function 
"static inline int gen_set_rtc_irq_bit(unsigned char bit)" in file 
genrtc.c it will down.

Can you help me? 

Thanks.
Leo


--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail is solely property of the sender's organization. This mail communication is confidential. Recipients named above are obligated to maintain secrecy and are not permitted to disclose the contents of this communication to others.
This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the originator of the message. Any views expressed in this message are those of the individual sender.
This message has been scanned for viruses and Spam by ZTE Anti-Spam system.

--=_alternative 0028C317482572DE_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">The system is Embeded Linux with kernel
2.6.14. And the CPU is MPC8270 of freescale. The rtc module is &quot;Generic
/dev/rtc emulation&quot; and &quot;Extended RTC operation&quot;. And the
chip of rtc is ds1338 with the interface of i2c. The module of i2c has
been included.</font>
<br>
<br><font size=2 face="sans-serif">When i enable the dcache of mpc8270
and use &quot;hwclock --hctosys&quot; or &quot;hwclock --show&quot;, the
system will down. But if i disable dcache, it is ok. </font>
<br><font size=2 face="sans-serif">I found that when it call <b>schedule_work(&amp;genrtc_task)
</b>in the function &quot;static inline int gen_set_rtc_irq_bit(unsigned
char bit)&quot; in file genrtc.c it will down.</font>
<br>
<br><font size=2 face="sans-serif">Can you help me? </font>
<br>
<br><font size=2 face="sans-serif">Thanks.</font>
<br><font size=2 face="sans-serif">Leo</font>
<br><br><pre>
--------------------------------------------------------
ZTE&nbsp;Information&nbsp;Security&nbsp;Notice:&nbsp;The&nbsp;information&nbsp;contained&nbsp;in&nbsp;this&nbsp;mail&nbsp;is&nbsp;solely&nbsp;property&nbsp;of&nbsp;the&nbsp;sender's&nbsp;organization.&nbsp;This&nbsp;mail&nbsp;communication&nbsp;is&nbsp;confidential.&nbsp;Recipients&nbsp;named&nbsp;above&nbsp;are&nbsp;obligated&nbsp;to&nbsp;maintain&nbsp;secrecy&nbsp;and&nbsp;are&nbsp;not&nbsp;permitted&nbsp;to&nbsp;disclose&nbsp;the&nbsp;contents&nbsp;of&nbsp;this&nbsp;communication&nbsp;to&nbsp;others.
This&nbsp;email&nbsp;and&nbsp;any&nbsp;files&nbsp;transmitted&nbsp;with&nbsp;it&nbsp;are&nbsp;confidential&nbsp;and&nbsp;intended&nbsp;solely&nbsp;for&nbsp;the&nbsp;use&nbsp;of&nbsp;the&nbsp;individual&nbsp;or&nbsp;entity&nbsp;to&nbsp;whom&nbsp;they&nbsp;are&nbsp;addressed.&nbsp;If&nbsp;you&nbsp;have&nbsp;received&nbsp;this&nbsp;email&nbsp;in&nbsp;error&nbsp;please&nbsp;notify&nbsp;the&nbsp;originator&nbsp;of&nbsp;the&nbsp;message.&nbsp;Any&nbsp;views&nbsp;expressed&nbsp;in&nbsp;this&nbsp;message&nbsp;are&nbsp;those&nbsp;of&nbsp;the&nbsp;individual&nbsp;sender.
This&nbsp;message&nbsp;has&nbsp;been&nbsp;scanned&nbsp;for&nbsp;viruses&nbsp;and&nbsp;Spam&nbsp;by&nbsp;ZTE&nbsp;Anti-Spam&nbsp;system.
</pre>
--=_alternative 0028C317482572DE_=--
