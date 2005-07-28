Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 2B96867D71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 22:51:48 +1000 (EST)
To: Igor Marnat <marny@rambler.ru>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 28 Jul 2005 16:03:22 +0400."
	<200507281603.22332.marny@rambler.ru>
Date: Thu, 28 Jul 2005 14:51:32 +0200
Sender: wd@denx.de
Message-Id: <20050728125132.7B8FD352584@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: eth1 on linux 2.4.25 from ELDK 3.1.1 becomes slowly when is
	pinged by great packets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Igor,

in message <200507281603.22332.marny@rambler.ru> you wrote:
>
> I tried to work with kernel 2.4.25 from ELDK 3.1.1 from Denx. My board is 
> PPChameleon EVB (PPC 405 EP). First, the kernel even didn't compile as is for 

You must be using old code (probably the version that came with  ELDK
3.1.1?).  Please  fetch  the  current  code from CVS; see commit "Fix
problems with second ethernet interface on 405EP".

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Any technology distinguishable from magic is insufficiently advanced.
