Return-Path: <akashkaul13@yahoo.com>
Received: from web14427.mail.yahoo.com (web14427.mail.yahoo.com
	[216.136.175.204]) by ozlabs.org (Postfix) with SMTP id 8ACE567A63
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 16:00:18 +1100 (EST)
Message-ID: <20050212045337.53362.qmail@web14427.mail.yahoo.com>
Date: Fri, 11 Feb 2005 20:53:37 -0800 (PST)
From: Akash kaul <akashkaul13@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: query regarding access of physical memory from user space  
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Some more doubts about the same thing.

As I am aware, the MPC8260 does not have a separate
I/O address space. 
> Yes,The MPC8260 I/O address space is mapped into 
> the Processors address space itself i,e the 256 Kb
> Internal memory which can be located anywhere in the
> 4 GB adress space using the IMMR register

So,
with reference to my earlier mail, when do we need to
use ioremap() and when
do we need to use request_mem_region()? Or do we need
to use both in a
particular sequence?

> For the MPC8260 you can access the I/O region  
> directly without an need for mapping.U can access 
> it thru the IMMR base address value.And specific 
> registers can be accessed by adding the register 
> offset to this value

Also, if I just do an ioremap(), can I directly access
those remapped
addresses with inb()/outb() or writeb()/readb()? Or is
something more to be
done prior to accessing it?

> u dont have to do an ioremap



Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf




		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
