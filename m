Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 38BCD2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Oct 2004 06:14:34 +1000 (EST)
To: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Oct 2004 13:59:54 CDT."
	<EFB813091B18D511BD3600508B644F820A618204@tx14exm06.ftw.mot.com>
Date: Fri, 22 Oct 2004 21:10:54 +0200
Sender: wd@denx.de
Message-Id: <20041022191059.ECE5AC146A@atlas.denx.de>
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

Dear Adam,

in message <EFB813091B18D511BD3600508B644F820A618204@tx14exm06.ftw.mot.com> you wrote:
> 
> What I referred to as "missed deadlines" were slips in order of +/- 20
> seconds. This was way out of line.

20 seconds? 

> Do you know if sysstat RPM is available for PPC?
> It'd be nice to have tools like sar and iostat for debugging my problem.

It is included with YDL (for YDL 3.0 it was on CD # 3 in file
YellowDog/RPMS/sysstat-4.0.5-3.ppc.rpm )

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Who is the oldest inhabitant of this village?"
"We haven't got one; we had one, but he died three weeks ago."
