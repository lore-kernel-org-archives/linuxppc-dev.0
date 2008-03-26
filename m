Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 520BBDE069
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 09:22:49 +1100 (EST)
To: Steve Heflin <sheflin@newagemicro.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ppc platform for AMCC-440EPx - ELDK to the rescue
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Mar 2008 09:08:03 -0400."
	<20080326130837.762DBDE2FB@ozlabs.org>
Date: Wed, 26 Mar 2008 23:22:47 +0100
Sender: wd@denx.de
Message-Id: <20080326222247.337AB242FC@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20080326130837.762DBDE2FB@ozlabs.org> you wrote:
> I finally resolved my nightmare of getting linux-2.6.24/5... to work 
> on my AMCC-440Epx - Sequoia spinoff board. Following a clue I derived 
> from a reply from Wolfgang Denx, I went to the DENX Engineering site 
> where I discoved and downloaded the ELDK for the ppc_4xxFP. the ELDK 
> uses the ppc platform instead of the powerpc platform.  FINALLY the 

This is not exactly correct. Actually it supports both.

> Also, I fail to see what the DTS virtualization layer of the hardware 
> buys us. When debugging, it's so much harder to use than the ppc 
> platform's straight forward and standard methodologies.  I can't 
> understand to goal to eliminate the ppc platform, especially given 
> the fact that DENX's ELDK is still using it with Linux 2.6.24.2 !!

You miss the fact that the ELDK has full  support  for  arch/powerpc,
and  that  some  board configurations in our kernel (for example, all
MPC5200 based ones)  are  available  in  arch/powerpc  configurations
only.

But then - what's the difference? All it takes is a  redefinition  of
the ARCH envrionment variable in your shell...

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I've got a bad feeling about this.
