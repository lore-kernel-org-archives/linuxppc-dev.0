Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 3E2BEDE025
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 01:37:03 +1000 (EST)
To: Stefan Roese <sr@denx.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 4/4 v2] [POWERPC] Kilauea defconfig file
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 11 Oct 2007 15:31:12 +0200."
	<200710111531.13022.sr@denx.de>
Date: Thu, 11 Oct 2007 17:37:00 +0200
Sender: wd@denx.de
Message-Id: <20071011153700.6E2272486E@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hallo Stefan,

In message <200710111531.13022.sr@denx.de> you wrote:
> 
> > If not, do you want this set by default so 
> > floating point instructions work?

No, we use soft-float on all such systems which is much faster.

> I just checked some existing arch/ppc defconfig files (and arch/powerpc too). 
> Most if not all have MATH_EMULATION not set. Even on those PPC's without FPU. 
> I assume we see no problems since soft-float is used while compiling.
> 
> Anyways, I'll change this and resubmit.

No, please leave as is.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Be kind to unkind people - they need it the most.
