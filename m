Return-Path: <timur.tabi@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 1D809DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 12:51:12 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so213723rnf.16
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 18:51:11 -0700 (PDT)
Message-ID: <ed82fe3e0810091851g1035f860u42ea22956aaa822@mail.gmail.com>
Date: Thu, 9 Oct 2008 20:51:11 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
In-Reply-To: <68168CE9-D17F-4C55-BF0B-0FAFC3672398@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop> <48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
	<18670.42312.827841.167852@cargo.ozlabs.ibm.com>
	<68168CE9-D17F-4C55-BF0B-0FAFC3672398@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 9, 2008 at 8:22 PM, Kumar Gala <galak@kernel.crashing.org> wrote:

>> The problem with making all platforms default to N is that if you take
>> the default values for all config options you end up with a config
>> that won't build.  So we want at least one platform to default to Y,
>> and pmac has been as good a choice as any for that (and probably still
>> is).

Ok, I can accept that.

> I've got no issue w/grandfathering CHRP or PMAC as default Y.  However I DO
> NOT think we should default other platforms to 'Y' as that means updating
> configs will pick up platforms they dont want.

As far as I know, CHRP and PMAC are the only PowerPC platforms that
default to Y.

-- 
Timur Tabi
Linux kernel developer at Freescale
