Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 4E1C967A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 18:27:46 +1000 (EST)
To: "Peter Gehirnforce" <Gehirnmann@gmx.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 May 2005 09:50:46 +0200."
	<25943.1115884246@www45.gmx.net>
Date: Thu, 12 May 2005 10:27:24 +0200
Sender: wd@denx.de
Message-Id: <20050512082729.CA255C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK/DENX linking fails for <iostream> 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <25943.1115884246@www45.gmx.net> you wrote:
> 
> when I try to link (after successful compile), I get the following type of

How exactly are you trying to link?

> errors (for example):
> ...
> undefined reference to 'std::allocator<char>::allocator[in-charge]()'
> ...
> undefined reference to '__cxa_allocate_exception'
> ...
> Can someone explain what happens?

This is most probably a usage error. But  you  don't  provide  enough
information.

Please show us  the  EXACT  commands  you're  using,  and  provide  a
(simple) example that shows the problem.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I don't mind criticism. You know me. I've  never  been  one  to  take
offence  at  criticism. No one could say I'm the sort to take offence
at criticism -- Not twice, anyway. Not without blowing bubbles.
                                  - Terry Pratchett, _Witches Abroad_
