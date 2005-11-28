Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15803.mail.cnb.yahoo.com (web15803.mail.cnb.yahoo.com
	[202.165.102.83]) by ozlabs.org (Postfix) with SMTP id 55051687C7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Nov 2005 14:21:57 +1100 (EST)
Message-ID: <20051128032155.18844.qmail@web15803.mail.cnb.yahoo.com>
Date: Mon, 28 Nov 2005 11:21:55 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: 8248 Reboot Puzzle
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

I met a reboot puzzle those days. Nearly every boards
of 20 samples had a symptom 
that after issuing a reboot command in Linux land more
than 10 times or so, the
target would encounter some unexpections like hang
after kernel uncompresing or
reset the target when initializing USB[VT6212L] 1.1
host controller. But I never
see any problem if cycle power. Then I have to switch
for a replacement method. 
In 8248 restart function, use a GPIO to pull LOW
POWER_RESET# to get a similar 
result and it did solve the problem. Well, if I use
the GPIO to pull LOW 
HARD_RESET#, problems still existed. I use 2.4.31
kernel.

So I wonder what the problem could be according to
your experience. Can we get
the same result with software as POWER_RESET does? I
also want to know more on the 
difference among software reboot and Power On reset
and Hard reset. I mean the
possibble effect on target running or initialization.

What I wanna to implement is a software power off and
on operation. 
Power-on -> waitting for power button pushing in
u-boot -> boot the target 
-> power off the target in Linux land by pushing the
power button
-> back to u-boot in a software power off state for
next power button pressing
-> ... 

Thanks in advance for any comments/suggestion,

Sam


	

	
		
___________________________________________________________ 
雅虎免费G邮箱－中国第一绝无垃圾邮件骚扰超大邮箱 
http://cn.mail.yahoo.com
