Message-Id: <200010180727.JAA13865@denx.local.net>
To: Dan Malek <dan@mvista.com>
cc: paulus@linuxcare.com.au, Tilmann Bitterberg <tibit-ibm@bitterberg.de>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: HIGHMEM now working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 18 Oct 2000 02:11:01 EDT."
             <39ED3EF5.FF4D52E6@mvista.com>
Date: Wed, 18 Oct 2000 09:27:56 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <39ED3EF5.FF4D52E6@mvista.com> Dan Malek wrote:
>
> move this to later.  I also use a #define IMMR for a pointer to the
> internal space of the processor.  Saves a few cycles, but I should
> really make this a variable.  I can use the #define because I know

What do you think about including IMMR in the board  info  structure,
and  using  this?  That's  what we're doing for PPCBoot systems (that
don't use/need a special boot loader).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Conceptual integrity in turn dictates that the  design  must  proceed
from  one  mind,  or  from  a  very small number of agreeing resonant
minds.               - Frederick Brooks Jr., "The Mythical Man Month"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
