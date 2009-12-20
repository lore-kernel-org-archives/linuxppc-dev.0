Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id DA75AB6F15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 08:58:34 +1100 (EST)
To: Hunter Cobbs <hunter.cobbs@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: DWC_OTG Issues
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1261340025.3473.15.camel@mobiLinux>
References: <1261176637-23912-1-git-send-email-ptyser@xes-inc.com>
	<1261190115.14590.5.camel@mobiLinux>
	<20091219185657.5FF29E85072@gemini.denx.de>
	<1261340025.3473.15.camel@mobiLinux>
Date: Sun, 20 Dec 2009 22:58:31 +0100
Message-Id: <20091220215831.EEBE43F6FF@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Hunter Cobbs,

In message <1261340025.3473.15.camel@mobiLinux> you wrote:
> 
> We're using Linux 2.6.30(.3)-denx.  We've worked on this issue a bit
> before, although at the time you were doing some work for AMCC on just
> accessing devices across a hub in general.  We've been using the driver
> for a few months now and it is very stable on first-use of the driver,
> but once we close a full-speed port and try to reopen, that's when we
> get error concerning not being able to allocate resources and getting
> -28 errors.  I don't have anything precise in front of me at the moment,
> my test equipment is at the office.  But this seems to be the issues
> that lead to the Enhanced Transaction Translation Scheduling changes in
> the main-line kernel.

If you have a detailed bug report, ideally including an easy to
reproduce test case to trigger the problem then please feel free to
send it to our support address.

> I'm mainly being, I believe, overly cautious about not including GPL
> code in the Synopsis driver simply because I'd rather be overly careful
> than be exposed to some liability later down the road if Synopsis
> decides they want to make their driver completely proprietary.  While
> the code is available, I'm not sure if we can include code from GPL
> sources in the Synopsis drivers without requiring the Synopsis driver to
> become completely GPL.  I am also not a lawyer, but I'd rather be
> cautious.

Well, their license is relatively simple: the driver is unsupported,
it "IS NOT an item of Licensed Software or Licensed Product under any
End User Software License Agreement or Agreement for Licensed
Product", and you "are permitted to use andredistribute this Software
in source and binary forms, with or without modification, provided
that redistributions of source code must retain this notice." And
there is no warranty, of course.

IANAL, but I see no risks here.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If I ever needed a brain transplant, I'd choose a teenager's  because
I'd want a brain that had never been used.
