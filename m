Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <E62DBC698514D511A1AC0003470C1314EE2BFC@exchange.mvis.com>
From: Keith Outwater <Keith_Outwater@mvis.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Recommendations for LXT971A PHY MII interrupt connection 
Date: Wed, 26 Dec 2001 15:56:30 -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the info Wolfgang!
As far as interrupt assignments go, the design is totally flexible as it
hasn't gone to fab yet.
Your statements below seem to imply that the Linux kernel doesn't' want or
need the MII interrupt. Is this correct?

 Keith

in message <E62DBC698514D511A1AC0003470C1314EE2BF3@exchange.mvis.com> you
wrote:
>
> Does anyone have specific recommendations as to the best way to connect an
> Ethernet PHY's MII
> management I/F interrupt to the processor?  I'm using an Intel LXT971A
PHY.

Ummm... what are your options? All designs look pretty similar to me,
the main difference being the interrupt pin they chose  for  the  PHY
interrupt, if any.

> For example, are the general purpose external interrupts on IRQ[0:6] or
the
> CPM interrupts on port C preferred?

Softwarewise, it's easier to use one of the IRQ pins.

> Is there a specific pin or interrupt that is preferred?

No.

> PS: (this is a bit off topic linux-wise, but related:  Wolfgang, what's
the
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
