Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 318412BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 06:03:58 +1000 (EST)
To: Sam Song <samlinuxppc@yahoo.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 14 Oct 2004 03:39:59 +0800."
	<20041013193959.57540.qmail@web15605.mail.cnb.yahoo.com>
Date: Wed, 13 Oct 2004 22:03:25 +0200
Sender: wd@denx.de
Message-Id: <20041013200330.DFBB8C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Meaning of BSP and LSP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20041013193959.57540.qmail@web15605.mail.cnb.yahoo.com> you wrote:
> 
> I'd like to make sure about the meaning of BSP and
> LSP. There is sth unclear in my mind, I am afraid.

Don't worry. These terms are not clearly defined at all.

> IMHO, BSP includes Board's Hardware Scheme and Boot
> Loader Code in Binary format or Source code. LSP
> should be composed of Development Kit like ELDK and
> Linux Kernel Source for special Board. I am right?

No. Both BSP and LSP are terms used by peple who try to turn software
into products that can be sold. They have vendor  specific  meanings.
Some vendors may bundle boot loader code with thei BSP, others don't.
Only  if  you  buy  the  BSP  from a hardware manufacturer there is a
chance that you will receive board schematics with it; etc. etc.  And
LSP  is  just  another  marketing term to hide that somebody tries to
sell free software the same way other RTOS vendors sell BSP's. If  it
includes tools or not depends again on the vendor.

My recommendation: don't care about these terms.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The management question ... is not _whether_ to build a pilot  system
and  throw  it away. You _will_ do that. The only question is whether
to plan in advance to build a throwaway, or to promise to deliver the
throwaway to customers.       - Fred Brooks, "The Mythical Man Month"
