Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 224EF2BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 09:56:30 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 08 Oct 2004 19:33:09 EDT."
	<Pine.LNX.4.60.0410081930510.3440@localhost.localdomain>
Date: Sat, 09 Oct 2004 01:56:06 +0200
Sender: wd@denx.de
Message-Id: <20041008235611.70B92C1430@atlas.denx.de>
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

In message <Pine.LNX.4.60.0410081930510.3440@localhost.localdomain> you wrote:
> 
> oh, sure, if you know the length, it's easy.  and who wants to count 
> those bytes?  not me.  that's why i long ago dropped the idea of 
> writing a function.

You mean it is more difficult to use "sizeof(foo)" as a parameter  to
a function than inside one of your macros?

Wow. You see me surprised.


I give up here.


Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Of all the things I've lost, I miss my mind the most.
