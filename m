To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Insmod trouble 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Apr 2004 18:17:46 MDT."
             <DCEAAC0833DD314AB0B58112AD99B93B06DAAE@ismail.innsys.innovsys.com>
Date: Fri, 02 Apr 2004 18:54:51 +0200
Message-Id: <20040402165457.0957DC10B8@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DCEAAC0833DD314AB0B58112AD99B93B06DAAE@ismail.innsys.innovsys.com> you wrote:
>
> I get the following unresolved functions when trying to insmod a module
> with some floating point math in it:

You cannot use floating point in kernel mode.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God made machine language; all the rest is the work of man.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
