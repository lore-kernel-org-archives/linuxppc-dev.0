Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id ED8862BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 06:20:27 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Oct 2004 15:52:59 EDT."
	<Pine.LNX.4.60.0410051543230.3549@localhost.localdomain>
Date: Tue, 05 Oct 2004 22:20:12 +0200
Sender: wd@denx.de
Message-Id: <20041005202017.6DC7BC1430@atlas.denx.de>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] first in a series to enhance microcode patches 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0410051543230.3549@localhost.localdomain> you wrote:
> 
> that's definitely understandable.  it's just potentially confusing to 
> have a structure's reserved chunks declared as some combination of 
> uchar, ushort, uint and/or ulong, when it's obviously more 
> comprehensible to make each reserved chunk a standard array of char 
> whose size is obvious at a glance.

Actually this might not be confusing, but making the code  easier  to
read,  to  understand,  and  maybe  one day to extend - remember that
these struct definitions are direct translations of Motorola provided
documentation - and I tend to  believe  that  the  chip  manufacturer
knows  more about the internals of his chips than you or me. One day,
a "uint reserved_xxx;" may turn into a new, shiny 32 bit register.

>    now *that* kind of creeps me out.  why is reserved space being 
> declared as "volatile"?  yeesh.

It does not hurt, and it makes it easier to adapt the code  when  new
register definitions pop up in a later version of the chip?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Intel told us the Pentium would have "RISK" features...
