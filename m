Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4A635679F6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 08:38:16 +1000 (EST)
To: Om Vadlapatla <pdfdoc15@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Failure of 2 BAT schemes to enable D-cache 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 11 May 2006 13:13:29 PDT."
	<20060511201329.23866.qmail@web37105.mail.mud.yahoo.com>
Date: Fri, 12 May 2006 00:38:14 +0200
Sender: wd@denx.de
Message-Id: <20060511223814.2195C352B0C@atlas.denx.de>
Cc: "U-Boot-Users@lists.sourceforge.net" <U-Boot-Users@lists.sourceforge.net>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20060511201329.23866.qmail@web37105.mail.mud.yahoo.com> you wrote:
>
> Please post comments and suggestions of how I can
> initialized MMU for d-cache performance. I am  new
> to this.

We have been through this before, several times. Many times actually.
I have explained it to you, and so did others.

It is perfectly fine with me if you ignore my advice. But then please
stop posting the same question again and again here.

You will not receive any new answers.

Again, and definitely for the last time:

It makes no sense to try to enable the data cache on a MPC82xx system
in U-Boot; the time you could save if you succeeded  is  marginal  to
your application startup time.

And in Linux the D-Cache is enabled, so no changes are needed.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
They say a little knowledge is a dangerous thing,  but it is not  one
half so bad as a lot of ignorance.   - Terry Pratchett, _Equal Rites_
