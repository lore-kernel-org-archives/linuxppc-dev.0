Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 392CF2BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 09:29:32 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 08 Oct 2004 19:10:01 EDT."
	<Pine.LNX.4.60.0410081908410.3331@localhost.localdomain>
Date: Sat, 09 Oct 2004 01:29:15 +0200
Sender: wd@denx.de
Message-Id: <20041008232920.C68C6C1430@atlas.denx.de>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: next pass of cleaning up micropatch.c 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0410081908410.3331@localhost.localdomain> you wrote:
> 
> >> nice idea, but sadly, doomed to failure.  note that the code to copy
> >> the patch arrays *requires* you to be able to take the sizeof() those
...
> > This is not right. Guess how memcpy() works - it's a function, btw.
> 
> sure.  and it accepts a size parameter, which is why it works.  i'm 
> not sure what you're getting at.

I'm getting at your "doomed to failure" argument.

I'm surprised that you didn't think about the possibility to pass the
patch length as an argument to the function, that's all.  This  seems
all  too  obvious  to  me.  (If  you like you can this make an inline
function - then the code will be more or less identical  to  what  we
have now [which does not make the code a bit better, btw.])

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only person who always got his work done by Friday
                                                 was Robinson Crusoe.
