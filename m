Message-Id: <200101301719.f0UHJXC12111@denx.local.net>
To: Ralph Blach <rcblach@raleigh.ibm.com>
cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: which errno should I use 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Jan 2001 11:52:51 EST."
             <3A76F163.406CBFDB@raleigh.ibm.com>
Date: Tue, 30 Jan 2001 18:19:33 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Ralph,

in message <3A76F163.406CBFDB@raleigh.ibm.com> you wrote:
>
> I am writing a character device driver.  I want this device driver to
> return an error if the user request less than say 1024 byte of data.
> What errno should I use?  Is it legal to return an error if not enouth

EINVAL (Invalid argument) is often used in this situation.

> bytes are requested?

Sure. Many character devices have certain restrictions on the I/O size.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
