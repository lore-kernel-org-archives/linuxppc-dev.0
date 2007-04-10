Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 42E6ADDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 05:18:10 +1000 (EST)
To: powerpc440 <powerpc440@googlemail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Multiple Boards with same MAC addresses - problem. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Apr 2007 16:51:04 +0200."
	<461BA458.2010605@googlemail.com>
Date: Tue, 10 Apr 2007 21:18:08 +0200
Sender: wd@denx.de
Message-Id: <20070410191808.5F197353B4B@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <461BA458.2010605@googlemail.com> you wrote:
> 
> I have multiple boards, based on ppc405ep (which include on-chip two
> ethernet ports). I'm configure the MAC address in u-boot and all works

You should post U-Boot related questions to the U-Boot-Users mailing
list. They are off topic here.

> great. The problem appears when I use two or more boards in one network,
> because the MAC addresses are the same. Now I'm making a own u-boots for
> each board, but this solution is not very comfortable.

Maybe you should start reading the manual and get a clue about the use
of environment variables in U-Boot.

> My question is, which is the standard way to resolve such problem? I
> would have only one generic u-boot. Is this possible?

Of  course  it  is.  Just  use  different  settings  of  the  ethaddr
environment variables.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is dangerous to be sincere unless you are also stupid.
                                                - George Bernard Shaw
