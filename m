Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15706.mail.cnb.yahoo.com (web15706.mail.cnb.yahoo.com
	[202.165.102.73]) by ozlabs.org (Postfix) with SMTP id 4D3AD67B93
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 21:46:33 +1100 (EST)
Message-ID: <20061103103952.54534.qmail@web15706.mail.cnb.yahoo.com>
Date: Fri, 3 Nov 2006 18:39:52 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
Subject: Why 8548 reset vector points to 0x00000000?
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I met a problem on a customized 8548 board debug
with BDI2000. After halting e500 core, PC pointed
to 0x0. But the same configuration file does work

on 8548 ref. board well as 0xfffffffc. I checked
all POR settings from registers and didn't find 
any clue on it. So far, BDI2000 cannot program
Flash. There is no code on Flash. What could the
problem be?

Thanks in advance,

Sam


	

	
		
___________________________________________________________ 
Mp3疯狂搜-新歌热歌高速下
http://music.yahoo.com.cn/?source=mail_mailbox_footer
