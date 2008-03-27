Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB5E3DE0A4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Mar 2008 07:37:17 +1100 (EST)
Date: Thu, 27 Mar 2008 16:36:45 -0400
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: ppc platform for AMCC-440EPx - ELDK to the rescue
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080327203717.EB5E3DE0A4@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>In reply to my message <20080326130837.762DBDE2FB@ozlabs.org>
> > I finally resolved my nightmare of getting linux-2.6.24/5... to work
> > on my AMCC-440Epx - Sequoia spinoff board. Following a clue I derived
> > from a reply from Wolfgang Denx, I went to the DENX Engineering site
> > where I discoved and downloaded the ELDK for the ppc_4xxFP. the ELDK
> > uses the ppc platform instead of the powerpc platform.  FINALLY the
Wolfgang replied At 06:22 PM 3/26/2008:
>This is not exactly correct. Actually it supports both.

Ah thank you for that info.  I only said what I said because the 
4xxFP installation set things up to use the arch/ppc and to my 
delight, it worked!  I look forward to and will do all I can to help 
get the arch/powerpc platform working on my Sequoia spin-off board.

I sent you email regarding my inability to do a ELDK build from 
scratch, did you get that? I'm trying to build it under a fully 
updated Fedora 7 system, and it hits the error:
   LD unable to locate -lssabi_krb5 .  Any clue?

thanks so much for your help,
Steve
