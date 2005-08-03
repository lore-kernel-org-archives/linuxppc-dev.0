Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id B63CC67E45
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 02:51:47 +1000 (EST)
To: =?big5?B?rn2z06vC?= <rober.hsu@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Aug 2005 00:28:16 +0800."
	<002701c59848$cb6b6ed0$0e01000a@orange>
Date: Wed, 03 Aug 2005 18:51:35 +0200
Sender: wd@denx.de
Message-Id: <20050803165135.755D5353BF9@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: about linux 2.4.25 on MPC852T 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <002701c59848$cb6b6ed0$0e01000a@orange> you wrote:
> 
>      I'm porting Linux 2.4.25 at my MPC852T.My first used is 2.4.4, I
> assign my board info ptr to 0x3400 and pass it to linux 2.4.4.

Ummm... are you sure you know what you are doing?

> It works fine. But 2.4.25's head.S changes much code  I don't know how
> to porting it. I need help.

Just have  a  look  at  the  existing  code.  MPC8xx  is  a  standard
architecture and has been supported since a long,, long time ago.

>     Another question is where can i find older kernel like 2.4.10,
> 2.4.12,2.4.18 for PowerPC?I know DENX Linux kernel source tree

You can find it for example in our CVS server.

> want and I don't how to used cvs command to get it.If anyone

If you don;t know the tools, and are not willing to try to  learn  to
use  these,  then  nobody  will  be able to help you. Try and hire an
expert.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
He had quite a powerful intellect, but it  was  as  powerful  like  a
locomotive,  and  ran on rails and was therefore almost impossible to
steer.                          - Terry Pratchett, _Lords and Ladies_
