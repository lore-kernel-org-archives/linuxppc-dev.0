Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id ED2C367BE5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 09:55:22 +1000 (EST)
To: "Samuel Osorio Calvo" <samuel.osorio@nl.thalesgroup.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 30 Jun 2005 18:01:47 +0200."
	<s2c4339f.015@scms1.sc.signaal.nl>
Date: Fri, 01 Jul 2005 01:54:29 +0200
Sender: wd@denx.de
Message-Id: <20050630235429.22D09353A1B@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: eth0 autonegotation 8260 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Samuel,

in message <s2c4339f.015@scms1.sc.signaal.nl> you wrote:
> 
...
> clocks and MDIO pins. I took changes somebody made with DENX's 2.4.18 and
> ported them to 2.4.25, probably forgeting something in the way....may be
> something related to interrupts interfaces has changed since then??? 

Ummm.... did you by chance try the  currnt  code  in  CVS,  which  is
2.4.25  based?  I am not aware of any problems in that area, at least
not on the boards we use for regular testing.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Anyone who isn't confused here doesn't really know what's going on.
