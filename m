Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 91E212BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 03:29:14 +1100 (EST)
To: annamaya <annamaya@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Dec 2004 15:07:12 PST."
	<20041214230712.79751.qmail@web53805.mail.yahoo.com>
Date: Wed, 15 Dec 2004 17:28:38 +0100
Sender: wd@denx.de
Message-Id: <20041215162843.8DFC4C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Initialization of Timer Clock on the MPC8260 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20041214230712.79751.qmail@web53805.mail.yahoo.com> you wrote:
> I am not sure if this is the right place to ask this
> question since this may be a U-Boot question. I am

Why do you ask here and not on the U-Boot mailing list then?

> trying to understand how the source for the timer
> clock is selected on this processor. Figure 4-3 tries
> to explain this but I am unable to find code in U-Boot
> that actually sets either BRG1 or one of the GPIO pins
> to act as inputs for the timer clock generation. Can
> someone point me to the right place in the code where

Well, did you check the place where all GPIO pins
get initialized, i. e. board/<name>/<name>.c ?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"To take a significant step forward, you must make a series of finite
improvements." - Donald J. Atwood, General Motors
