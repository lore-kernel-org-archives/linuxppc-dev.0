To: "Ross A. Osborn" <rosborn@GI.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Progress - new problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Feb 2001 09:54:29 EST."
             <20010212095429.E8453@gi.com>
Date: Mon, 12 Feb 2001 17:35:39 +0100
Message-Id: <20010212163544.4458A281DA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Ross,

in message <20010212095429.E8453@gi.com> you wrote:
>
> I have been fighting with an old Nohau BDM debugger and was trying to
> get information together to talk my boss into ordering the BDI2000.  I
> could not find any price information on there web site.

Please understand that I cannot speak for the design and contents  of
Abatron's  web pages.

Speaking for us: we are a reseller for Abatron, and I  certainly  can
send  you a quote. But I'm pretty sure there is US based reseller for
Abatron, too. I have no idea if the US prices  are  highr  or  lower
than ours.

> So, the right thing to do is to send you a message to a quote?  Is it
> just me or is this an odd way to conduct business?

In such situations I'm biased when posting to the  mailing  list.  On
one  side,  I like to help, and give the best advice I am able to. On
the other  side,  this  _is_  commercial  advertising,  and  as  such
inappropriate for the list.

If we're talking directly to each other, we can talk clean business :-)

> This will certainly not make it any easier to convice my boss to buy
> this instead of (or in addition to) the EST products they are currently
> looking at.

Well, when comparing products, just ask a few questions:

* How much does the Linux version of the debugger cost? [And how much
  is the Windows version, and why is there a difference, if any?]

  Our price for  the  BDI2000  bundled  with  bdiGDB  software  which
  interfaces  to  GDB  is  2500  Euro, or about $ 2325 (including the
  power supply).

* Does the debugger support the MMU? Will you get  a  guarantee  that
  you  can  use  it to symbolically debug the LInux kernel, including
  automatic variables (on the stack)?

  Many debuggers fail here, and AFAIK the EST is one of them.  Lately
  I've heard that they provide some MMU support, but it sounded as it
  was  just  for  static  mappings,  so  it  would  fail  for dynamic
  situations like data on the stack.

* Is there any warranty? The BDI2000 comes with 3 years  of  warranty
  for the hardware.

* How good is there  support  if  you  have  any  problems,  or  need
  extensions, etc.?


OK, now I want to ask you a question: what hardware do you  have?  If
you  can  do  with  BDM,  are  you  aware  of  the BDM4GDB project at
sourceforge? You can built the parallel port adapter yourself, or get
it for less than $ 50.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
