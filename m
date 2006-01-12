Return-Path: <wd@denx.de>
To: David Tao <david_xtao@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Jan 2006 20:30:50 PST."
	<20060112043050.18822.qmail@web32102.mail.mud.yahoo.com>
Date: Thu, 12 Jan 2006 08:37:34 +0100
Sender: wd@denx.de
Message-Id: <20060112073734.023F5353CCD@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Question about SPI based CAN controller for MPC8260 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20060112043050.18822.qmail@web32102.mail.mud.yahoo.com> you wrote:
>
>   1. Is it possible to add CAN to MPC8270 with SPI interface using the MCP2515? Is there any better solution for the job?

It may be technically possible, but it is IMHO not a good  idea.  SPI
on  the  MPC8xx  /  MPC82xx  is  implemented  in software (microcode)
running on the CPM, and runs with the lowest priority there. This can
cause (and has caused) serious problems  for  example  in  situations
where ther CPM is working under high load, etc.

It's much easier to interface one of the common CAN controllers  (for
which drivers are available, too).

>   2. If yes, is there any such linux driver?

Never heard of it.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Unix is supported by IBM, like a hanging man is supported by rope.
		        - Don Libes & Sandy Ressler: _Life With Unix_
