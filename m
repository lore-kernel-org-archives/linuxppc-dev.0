Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 3BE4367A77
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 04:48:56 +1100 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Feb 2005 16:50:53 +0100."
	<200502171650.53799.david.jander@protonic.nl>
Date: Thu, 17 Feb 2005 18:48:34 +0100
Sender: wd@denx.de
Message-Id: <20050217174839.48A3DC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Which kernel tree for future 8xx development? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200502171650.53799.david.jander@protonic.nl> you wrote:
> 
> 
> Now I am observing myself doing apparently absurd things as for example taking 
> arch/ppc/8260_io/cpm_spi.c from DENX and putting it into arch/ppc/8xx_io/ 
> from bitkeeper and hacking until it works (again). It still doesn't. Where on 
> earth is the original driver (which was for MPC860, not MPC8260)!??

That's probably arch/ppc/8xx_io/cpm_spi.c from our old linux-2.4
kernelk tree.

> Before we port all of our stuff once again from one tree to another, can 
> someone please give me a good advice on which way to go now and in forseeable 
> future? 

I cannot answer this question - maybe once there  is  a  clear  split
between  stable  and  development  kernel  trees again. At the moment
there is only chaos.

Best regards,

Wolfgang Denk

-- 
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Mr. Cole's Axiom:
        The sum of the intelligence on the planet is a constant;
        the population is growing.
