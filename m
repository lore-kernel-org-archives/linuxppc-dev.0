Return-Path: <dcogley@uslinc.com>
Received: from que02.charter.net (que02.charter.net [209.225.8.190])
	by ozlabs.org (Postfix) with ESMTP id 54F30DE0B6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 10:51:38 +1100 (EST)
Received: from aarprv06.charter.net ([10.20.200.76]) by mta11.charter.net
	(InterMail vM.7.08.03.00 201-2186-126-20070710) with ESMTP
	id <20080326225649.GISK5653.mta11.charter.net@aarprv06.charter.net>
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Mar 2008 18:56:49 -0400
Received: from DCOGLEYNEW ([71.93.35.174]) by aarprv06.charter.net with ESMTP
	id <20080326225648.JPHD11293.aarprv06.charter.net@DCOGLEYNEW>
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Mar 2008 18:56:48 -0400
From: "Dave Cogley" <dcogley@uslinc.com>
To: <linuxppc-embedded@ozlabs.org>
References: Your message of "Wed,
	26 Mar 2008 09:08:03 -0400."<20080326130837.762DBDE2FB@ozlabs.org>
	<20080326222247.337AB242FC@gemini.denx.de>
Subject: RE: ppc platform for AMCC-440EPx - ELDK to the rescue
Date: Wed, 26 Mar 2008 15:56:23 -0700
Message-ID: <006e01c88f94$9dafe020$2001a8c0@DCOGLEYNEW>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20080326222247.337AB242FC@gemini.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang,

Could you provide an explanation between the two architectures in the ELDK?


I am also using a Sequoia "spin off" and am trying to determine why I would
want to use the "powerpc" architecture vs. the "ppc" architecture.  

Thanks,
Dave

-----Original Message-----
From: linuxppc-embedded-bounces+dcogley=uslinc.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+dcogley=uslinc.com@ozlabs.org] On Behalf
Of Wolfgang Denk
Sent: Wednesday, March 26, 2008 3:23 PM
To: Steve Heflin
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ppc platform for AMCC-440EPx - ELDK to the rescue

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
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
