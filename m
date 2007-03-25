Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6EF6FDDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Mar 2007 05:35:27 +1000 (EST)
To: Thomas Maenner <tmaenner@aehr.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: TQM 860L, 64MB RAM, ELDK4.1, TQM860L, Kernel 2.6.19 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Mar 2007 10:29:04 MST."
	<200703231029.04488.tmaenner@aehr.com>
Date: Sun, 25 Mar 2007 21:35:24 +0200
Sender: wd@denx.de
Message-Id: <20070325193524.824BC35264E@atlas.denx.de>
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

In message <200703231029.04488.tmaenner@aehr.com> you wrote:
> 
> please enlighten us (or maybe just me) on why the TQ8xx are not supported by 
> 2.6, since the ppc sources are in the 2.6.19 kernel source tree, that comes 
> with ELDK 4.1

The working 2.4 code was copied to 2.5 and later to 2.6 without  ever
being  actively maintained. In early 2.6 kernels, support for 8xx was
more or less broken. Lately, it has become clear that ARCH=ppc  is  a
dead end and things should move to ARCH=powerpc. That's why I said we
(DENX) will not support the 8xx in the ARCH=ppc context.

Last but not least I would like to remind you that 2.6 is bigger and
slower than 2.4, which is especially visible on low end systems like
the 8xx.

The kernel code that comes with the ELDK is very close to the vanilla
kernel.org tree (plus some local extensions that have  not  yet  been
pushed  upstream).  The  8xx  support  in  both  trees  is absolutely
identical, i. e. the fact that 8xx code is in the ELDK has  the  very
same reason why x86 code is there, or why sh4 or etrax or ... code is
theee,  even  if these systems are not supported by the ELDK at all -
this code is part of the vanilla kernel.org tree.

AFAIK, 2.6 has never been fully ported to  the  TQM8xxL  and  TQM8xxM
systems yet.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Computers are not intelligent.  They only think they are.
