To: Xavier Miville <xmiville@oerlikon.ca>
Cc: v.sudeep@exgate.tek.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI daughter card with USB on a 405GP 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "23 Feb 2004 11:29:10 EST."
             <1077553750.11751.7.camel@PC856-DDUVAL.oerlikon.ca>
Date: Mon, 23 Feb 2004 18:09:32 +0100
Message-Id: <20040223170937.BB7C5C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1077553750.11751.7.camel@PC856-DDUVAL.oerlikon.ca> you wrote:
>
> I've used a PCI card with a NEC upd720100A HC (a StarTech PCI4USBV2)
> with my walnut evb, kernel 2.4.22 and the linuxppc-2.4.22 patch.
>
> The OHCI was working fine, but installation of the EHCI (USB2.0) did
> froze the system (didn't had time to debug this problem).

We tested a Adaptec AUA-200LP USB 2.0 card in  some  PPC  sytems.  It
worked fine when the devices were already connected at power-on or at
least  when  booting  Linux,  while hot-plug would reliably crash the
kernel. As far as I understand such behaviour is typical of  some  of
the alignment/cache bugs in the Linux kernel's USB code.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All I ask is a chance to prove that money can't make me happy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
