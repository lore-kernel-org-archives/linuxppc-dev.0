To: Erik Christiansen <erik@dd.nec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anyone built a PPC cross compiler on debian? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Oct 2002 13:54:45 +1000."
             <20021003035445.GA2987@dd.nec.com.au>
Date: Thu, 03 Oct 2002 09:39:45 +0200
Message-Id: <20021003073950.913CBFA9A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021003035445.GA2987@dd.nec.com.au> you wrote:
>
>    Penguinppc.org's "Cross Development mini-howto for PPC Linux" failed
> to build on my x86 debian woody host, due to an autoconf bug. (Thanks to
> Hollis Blanchard for identifying this.)
>
>    Also looked at the "Embedded Linux Development Kit" at www.denx.de,
> but the list of supported hosts does not include debian.

Did you try out? One of our developers is running Debian, and he says
the ELDK works. The fact that  it's  not  officially  supported  just
means that we did not run the full set of tests on that platform.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one  instruction  --  from  which,  by induction, one can deduce that
every program can be reduced to one instruction which doesn't work.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
