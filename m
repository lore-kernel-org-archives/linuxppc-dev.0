To: Dan Malek <dan@embeddededge.com>
Cc: laurent.pinchart@capflow.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 06 Mar 2002 11:28:39 EST."
             <3C8643B7.60506@embeddededge.com>
Date: Wed, 06 Mar 2002 18:09:41 +0100
Message-Id: <20020306170947.078ED109EB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C8643B7.60506@embeddededge.com> you wrote:
>
> it was tracked down to a UPM/SDRAM timing problem.  People keep talking
> about running > 50 MHz bus on these newer parts, is there something
> different about the memory controller that allows this and may cause
> compatibility problems?  I have (fortunately :-) not looked at this
> level of detail in the newer parts.

There are no differences AFAIK. It's just a faster CPU that allows 66
or even 76 MHz with 1:1 CPU/bus clock mode.

We have a MPC823E system here that runs at 66 MHz, and I will have  a
MPC855T  at 66MHz in 18 hours from now. So far I didn't encounter any
problems - of course you have to adjust the UPM tables and what  else
you need to initialize the memory controller.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The Wright Bothers weren't the first to fly. They were just the first
not to crash.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
