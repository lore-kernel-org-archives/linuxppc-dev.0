Return-Path: <annamaya@yahoo.com>
Received: from web53804.mail.yahoo.com (web53804.mail.yahoo.com
	[206.190.36.199]) by ozlabs.org (Postfix) with SMTP id C9D7767A66
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jan 2005 09:49:38 +1100 (EST)
Message-ID: <20050120224936.33390.qmail@web53804.mail.yahoo.com>
Date: Thu, 20 Jan 2005 14:49:36 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Kernel booting issues on a MPC8270 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to boot a mvista Linux Kernel ver. 2.4.20
on  a MPC8270 board. I am using the embed_config() in
zImage to pass the board info since the bootloader is
not ppcboot. After the message, "Now booting the
kernel", the board just reboots, as if someone yanked
the reset line. I have BDI hooked up but it doesn't
seem to catch the reset point in the code. And I am
unable to trace this to anything in the code. Any
suggestions? Thanks in advance.


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
