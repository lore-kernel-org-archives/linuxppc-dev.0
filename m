Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id 8876D67A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 03:32:47 +1100 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Mar 2005 10:14:41 EST."
	<Pine.LNX.4.61.0503171011220.20335@localhost.localdomain>
Date: Thu, 17 Mar 2005 17:32:18 +0100
Sender: wd@denx.de
Message-Id: <20050317163223.6C37EC1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: looking for a model for building CRAMFS(?)-based system 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Robert,

in message <Pine.LNX.4.61.0503171011220.20335@localhost.localdomain> you wrote:
> 
> now this is the sticky part.  imagine this system out in the field,
> where you need to make an update to something in the initrd in the
> root filesystem.

This is the szenario where an overly filesystem enters the stage.

See http://www.denx.de/e/news.php#MINI_FO

Note that the overlay filesystem was developed specifically for  this
purpose;  it  has been in production use in some telecom products for
over a year now.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Only in our dreams we are free.  The rest of the time we need  wages.
                                    - Terry Pratchett, _Wyrd Sisters_
