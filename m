To: Keith Outwater <Keith_Outwater@mvis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Recommendations for LXT971A PHY MII interrupt connection 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Dec 2001 08:45:00 PST."
             <E62DBC698514D511A1AC0003470C1314EE2BF3@exchange.mvis.com>
Date: Wed, 26 Dec 2001 20:43:56 +0100
Message-Id: <20011226194401.C86BA10E25@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Keith,

in message <E62DBC698514D511A1AC0003470C1314EE2BF3@exchange.mvis.com> you wrote:
>
> Does anyone have specific recommendations as to the best way to connect an
> Ethernet PHY's MII
> management I/F interrupt to the processor?  I'm using an Intel LXT971A PHY.

Ummm... what are your options? All designs look pretty similar to me,
the main difference being the interrupt pin they chose  for  the  PHY
interrupt, if any.

> For example, are the general purpose external interrupts on IRQ[0:6] or the
> CPM interrupts on port C preferred?

Softwarewise, it's easier to use one of the IRQ pins.

> Is there a specific pin or interrupt that is preferred?

No.

> PS: (this is a bit off topic linux-wise, but related:  Wolfgang, what's the
> preferred method as far a ppcboot is concerned?)

Being lazy, the preferred  (by  me)  method  is  not  to  use  a  PHY
interrupt  at  all  :-) You need the PHY interrupt only in cases when
you need to get informed about link status changes. Few  applications
really  need  this  type of information (although it's "interesting",
especially during board bring-up).

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bradley's Bromide: If computers get too  powerful,  we  can  organize
them into a committee - that will do them in.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
