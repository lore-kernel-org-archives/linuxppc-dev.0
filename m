Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15616.mail.cnb.yahoo.com (web15601.mail.cnb.yahoo.com
	[202.165.102.55]) by ozlabs.org (Postfix) with SMTP id CC1B2DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 12:56:46 +1100 (EST)
Date: Wed, 23 Jan 2008 09:50:04 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: BDI Problems
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Message-ID: <986902.37818.qm@web15601.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, all:
I am using BDI2000 with PowerPC. Sometimes, when I try
to change configuration of BDI2000 for different
PowerPC boards, the configuring procedure may meet the
following errors:

root@laz:/home/zhour/bdi2000sw/bdisetup2007#
./bdisetup -v -p/dev/ttyS0 -b115
Connecting to BDI loader failed (-1201)

I also have tried /dev/ttyS1 and got the same result,
and I am sure there is not any other programs
occupying the serial ports. So would anyone give me
some advice about this?

Another problem is "PPC: JTAG instruction stuff
overrun" during debugging. For this error, I found an
explanation (http://www.ultsol.com/faq_p202.htm):
"When in debug mode the PPC4xx fetches normal PPC
instructions from the JTAG port. The error "# PPC:
JTAG instruction stuff overrun" is raised when the
processor stops fetching from the JTAG port, possibly
because the processor hangs at an un-terminated memory
transfer." The proposed resolution is based on the
modification of configuration file. However, I have
tried that but it seems to have no effect.

Best wishes

Best wishes

Zhou Rui
Distributed and Embedded System Lab
Room 532, Information Building
School of Information Science
Lanzhou University, P. R. China
Tel: 86-0931-8912025
Zip Code: 730000


      ___________________________________________________________ 
ÑÅ»¢ÓÊÏä´«µÝÐÂÄê×£¸££¬¸öÐÔºØ¿¨ËÍÇ×Åó£¡ 
http://cn.mail.yahoo.com/gc/index.html?entry=5&souce=mail_mailletter_tagline
