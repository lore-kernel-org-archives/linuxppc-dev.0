Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 064F62BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 08:34:32 +1000 (EST)
To: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 21 Oct 2004 16:55:13 CDT."
	<EFB813091B18D511BD3600508B644F820A618202@tx14exm06.ftw.mot.com>
Date: Fri, 22 Oct 2004 00:34:04 +0200
Sender: wd@denx.de
Message-Id: <20041021223409.7BD1EC146A@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Help on tuning the Linux kernel for soft real-time requiremen
	ts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <EFB813091B18D511BD3600508B644F820A618202@tx14exm06.ftw.mot.com> you wrote:
> 
> Gerald, you may be right about this. Although I still don't know which of
> the threads in our system cause the serial resource contention, I

Check the console driver first.

> BTW, are you guys aware of any tool that could help me debug the threads
> that would concurrently try to access shared resources?
> Do you think LTT would be helpful for this particular problem (serial driver

LTT is certaily useful; but be aware that it may generate a  of  data
in  short  time,  which then needs a lot of work to really understand
what's going on ;-)

> contention that leads to missing soft real-time deadlines)?

I'm not exaclty sure I really understand what  you  are  asking  for.
Isn't  sometimes  missing  the  deadlines what the "soft" is standing
for? ;-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There's another way to survive.  Mutual trust -- and help.
	-- Kirk, "Day of the Dove", stardate unknown
