To: "Dick Read (SkyLynx)" <dread@skylynx.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: quad uart driver for 852T 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Dec 2003 14:29:44 PST."
             <NGBBKDOAELJBKFGCBALKCEMLCEAA.dread@skylynx.com>
Date: Tue, 09 Dec 2003 00:07:10 +0100
Message-Id: <20031208230715.DFC1AC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NGBBKDOAELJBKFGCBALKCEMLCEAA.dread@skylynx.com> you wrote:
>
> Hello.  I am new to Embedded Linux and wish to find a driver or code for a
> quad uart chip that I can use with the Analogue & Micro Adder II (MPC852T)
> reference board.  I have never done a Linux driver before but am willing to
> take the plunge here if I have to.  I see that someone as worked with a
> 16C554 on this mailing list and might have it working by now.  Besides the

We are working on such a thing, too (although  with  a  very  special
hardware  interface;  the  chip  is attached to the PCMCIA controller
ports ...). We'll check it in on our CVS server  within  the  next  4
weeks or so.

> suggestions for the UART code, what is the etiquette for asking people about
> their work?  I have often heard Linux has tons of drivers but how do you
> find the ones you need?

Google, then ask.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You Don't Have To Be 'Damned' To Work Here, But It Helps!!!
                                             - Terry Pratchett, _Eric_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
