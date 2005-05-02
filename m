Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 9D15167B46
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 May 2005 20:28:34 +1000 (EST)
To: "s.deepak" <s.deepak@gdatech.co.in>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 May 2005 12:22:39 +0530."
	<02cb01c54ee3$87e93ec0$4000a8c0@DeepakS>
Date: Mon, 02 May 2005 12:28:15 +0200
Sender: wd@denx.de
Message-Id: <20050502102820.2024CC1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Memory Usage Growth in File access 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <02cb01c54ee3$87e93ec0$4000a8c0@DeepakS> you wrote:
>
> I am  facing an issue in file operation, when we read/write continuously
> to  a large file in our  ppc 405 based device , memory usage shown in
> /proc/meminfo   increases by the number of bytes accessed.And after
> closing the application also the memory used is not released and  it
> goes to cached memory .

Welcome to the world of efficient use of resources.

What you see is perfectly normal behaviour and  one  of  the  reasons
that LInux provides excellent performance.

> Can anyone suggest me some idea how to trace out the problem.

There is no problem. What you see is normal the way it  was  designed
to work.

> When i run the below given code first time the memory grows,when  i run
> succesively it doesn't grow again , may be using the already taken
> memory.

Indeed. Also if you have a way to  trace  accesses  to  your  storage
media  you  will see that the secondrun needs much less accesses, and
is faster, too.

Welcome to Unix.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Today is the yesterday you worried about tomorrow.
