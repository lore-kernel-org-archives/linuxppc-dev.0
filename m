Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 6EFD52BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 08:32:49 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 08 Oct 2004 16:46:26 EDT."
	<Pine.LNX.4.60.0410081643100.25430@dell.enoriver.com>
Date: Sat, 09 Oct 2004 00:32:38 +0200
Sender: wd@denx.de
Message-Id: <20041008223243.7D84CC1430@atlas.denx.de>
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

In message <Pine.LNX.4.60.0410081643100.25430@dell.enoriver.com> you wrote:
> 
> nice idea, but sadly, doomed to failure.  note that the code to copy 
> the patch arrays *requires* you to be able to take the sizeof() those 
> arrays to know *exactly* how much to copy.  if you pass the array to a 
> function by its address, i'm pretty sure you lose the ability to take 
> its sizeof() anymore, isn't that right?

This is not right. Guess how memcpy() works - it's a function, btw.

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God runs electromagnetics by wave theory on  Monday,  Wednesday,  and
Friday,  and the Devil runs them by quantum theory on Tuesday, Thurs-
day, and Saturday.                                   -- William Bragg
