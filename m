To: Linh Dang <linh@home.earth>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux is not reliable enough? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Jul 2004 23:02:15 EDT."
             <wn5pt6mw1jc.fsf@linhd-2.ca.nortel.com>
Date: Sun, 25 Jul 2004 18:23:26 +0200
Message-Id: <20040725162332.05AC2C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <wn5pt6mw1jc.fsf@linhd-2.ca.nortel.com> you wrote:
>
> Well, X server doesn't run in the same vm space as the
> kernel. however, on my PC, X is the thing that would most likely to
> put the system into an unusable state (frozen keyboard, mouse and
> screen).

This just means that X is crashed. I'm  pretty  sure  the  system  is
stillr  unning  fine, and you can for example login over the network.
This example has lttle relevance to embedded system.

> QNX's drivers run in their own process space but they still have
> direct access to the hardware. A driver can screw up the hw regardless
> whatever vm-sandbox in which it run.

Indeed.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Dear Lord: I just want *one* one-armed manager so  I  never  have  to
hear "On the other hand", again.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
