Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 7038B67C36
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jul 2005 03:00:10 +1000 (EST)
To: Susheel Raj <susheel_nuguru@yahoo.co.in>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 15 Jul 2005 05:20:29 PDT."
	<20050715122030.13663.qmail@web8506.mail.in.yahoo.com>
Date: Fri, 15 Jul 2005 18:54:47 +0200
Sender: wd@denx.de
Message-Id: <20050715165447.F32683539FE@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot failure help needed 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050715122030.13663.qmail@web8506.mail.in.yahoo.com> you wrote:
> 
> now the problem is that if i use MPC5200 Rev A then
> the kernel boots without any problem and gets into the
> command 
> 
> but when i am using MPC5200 Rev B it shows like this

You need BAPI v2.2 for the Rev. B processors.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
God runs electromagnetics by wave theory on  Monday,  Wednesday,  and
Friday,  and the Devil runs them by quantum theory on Tuesday, Thurs-
day, and Saturday.                                   -- William Bragg
