Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4CD3567D77
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Nov 2006 03:45:28 +1100 (EST)
To: tran vanle <vantranbk@yahoo.com.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Not show login correct 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 04 Nov 2006 01:27:57 +1100."
	<20061103142757.35508.qmail@web33012.mail.mud.yahoo.com>
Date: Fri, 03 Nov 2006 17:45:26 +0100
Sender: wd@denx.de
Message-Id: <20061103164526.11621352658@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20061103142757.35508.qmail@web33012.mail.mud.yahoo.com> you wrote:
>
> I have just build kernel and ramdisk for TQM8xxL success. But when I login I receive 
> [root@h W] , my hostname is van and current directory is /root/bin ,May I receive [root@van bin]
..
> PS1="[$USER@\h \W]\\$ "

Check if your shell really supports such escape  sequences.  I  guess
you  might  be  running  something different than bash which does not
understand this.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you fail to plan, plan to fail.
