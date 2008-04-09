Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A2293DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 16:18:59 +1000 (EST)
To: David Gibson <david@gibson.dropbear.id.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Question on mpc52xx_common.c
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Apr 2008 09:51:50 +1000."
	<20080408235150.GA8092@localhost.localdomain>
Date: Wed, 09 Apr 2008 08:18:57 +0200
Sender: wd@denx.de
Message-Id: <20080409061857.4E15924842@gemini.denx.de>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20080408235150.GA8092@localhost.localdomain> you wrote:
>
> This is why I've always had mixed feelings about merging device trees
> into u-boot, rather than having them supplied by the wrapper.

On the other hand, we can now use  the  device  tree  to  dynamically
configure  U-Boot,  thus  allowing  to  run  the same binary image of
U-Boot on several different hardware configurations.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Parkinson's Law:  Work expands to fill the time alloted it.
