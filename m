Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id D573F680F2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 00:57:06 +1000 (EST)
To: vinay hegde <thisismevinay@yahoo.co.in>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 06 Sep 2005 14:00:29 BST."
	<20050906130029.74727.qmail@web8405.mail.in.yahoo.com>
Date: Tue, 06 Sep 2005 16:54:05 +0200
Sender: wd@denx.de
Message-Id: <20050906145405.BFEC5352661@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Regarding the PPC board bringup with Linux 2.6 kernel 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050906130029.74727.qmail@web8405.mail.in.yahoo.com> you wrote:
>   
> Does anybody have any idea about the problem? Also,

Yes.

> is it possible to print some debug messages at this
> point of booting? {Note that, in the early stage of

Use a BDI2000.

> Can somebody help me with the above problem?

Maybe you start reading the FAQ... See
http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A wise person makes his  own  decisions,  a  weak  one  obeys  public
opinion.                                           -- Chinese proverb
