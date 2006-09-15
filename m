Return-Path: <shawnxjin@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id A8B9E67B58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 09:06:18 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so4171931pyc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 16:06:15 -0700 (PDT)
Message-ID: <c3d0340b0609151606i2d01b963h4c7cd6a182d8c80@mail.gmail.com>
Date: Fri, 15 Sep 2006 16:06:14 -0700
From: "Shawn Jin" <shawnxjin@gmail.com>
To: "Matt Porter" <mporter@embeddedalley.com>
Subject: Re: ARCH=ppc or ARCH=powerpc
In-Reply-To: <20060824132338.GA27468@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
	<1156423796.5640.23.camel@zod.rchland.ibm.com>
	<1156424295.19482.11.camel@localhost>
	<20060824132338.GA27468@gate.crashing.org>
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

Hi Matt,

> The goal is to have the new 4xx arch/powerpc support not break 4xx
> arch/ppc support. So as boards are merged and verified working,
> we'll remove the equivalent support from arch/ppc...
>
> Some boards/chips may just die if no maintainer step up to port
> them over...but all the important stuff should get an interested
> party once we get the initial 4xx support in arch/powerpc working.

When can we expect this done? I have a 440 based SoC project ongoing
and am thinking when I should start moving to arch/powerpc.

THanks,
-Shawn.
