Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9AFBBDDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 04:48:30 +1000 (EST)
To: Johan Borkhuis <j.borkhuis@dutchspace.nl>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problems enabling NTP on ELDK
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 05 Sep 2007 13:29:38 +0200."
	<46DE9322.7080901@dutchspace.nl>
Date: Wed, 05 Sep 2007 20:48:27 +0200
Sender: wd@denx.de
Message-Id: <20070905184827.26859247AF@gemini.denx.de>
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

In message <46DE9322.7080901@dutchspace.nl> you wrote:
> 
> I tried enabling NTP on my embedded machine (using ELDK 4.1, ppc_85xx, 
> kernel version 2.6.14 with Xenomai 2.3.2). After I did that I noticed 
> that ksoftirqd/0 suddenly took almost all processor time (> 95%). What 
> is causing this? Is there a way around this, or is this something that 
> does not cause any problems?

You probably have some poroblems in your kernel port - check the  RTC
driver  and  related  modules like I2C etc. Of course this depends on
the NTP configuration you use, but the only kernel interaction I  can
think  of  that  could cause this is if you interact with the RTC. [I
guess that normal network traffic is working fine on your board.]

BTW: ELDK 4.1 comes with a 2.6.19.2  kernel  -  is  there  a  special
reason that you use such an obsoletel kernel tree?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Bankers do it with interest (penalty for early withdrawal).
