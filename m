Return-Path: <annamaya@yahoo.com>
Received: from web53804.mail.yahoo.com (web53804.mail.yahoo.com
	[206.190.36.199]) by ozlabs.org (Postfix) with SMTP id 23ADB2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Oct 2004 07:03:47 +1000 (EST)
Message-ID: <20041015205903.1653.qmail@web53804.mail.yahoo.com>
Date: Fri, 15 Oct 2004 13:59:03 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Floating point error on a MPC8280 based board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


When I try to reboot my system on a MPC8280 eval
board, I see the floating point error. Does anyone
know why is this happening?

bash-2.05b# reboot -f
Restarting system
floating point used in kernel (task=cf458000,
pc=ff000104)

Thank you.
-Navin.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
