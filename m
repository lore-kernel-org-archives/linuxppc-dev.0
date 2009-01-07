Return-Path: <opurdila@ixiacom.com>
Received: from ixro-ex1.ixiacom.com (unknown [212.146.94.66])
	by ozlabs.org (Postfix) with ESMTP id 7A51EDE5E9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 23:22:32 +1100 (EST)
From: Octavian Purdila <opurdila@ixiacom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/2] oprofile support for ppc750
Date: Wed, 7 Jan 2009 14:17:11 +0200
References: <1231246535-13151-1-git-send-email-opurdila@ixiacom.com>
	<1231296754.14860.51.camel@pasglop>
In-Reply-To: <1231296754.14860.51.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901071417.11745.opurdila@ixiacom.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> On Tue, 2009-01-06 at 14:55 +0200, Octavian Purdila wrote:
> > Adds oprofile support for ppc750. ppc750 performance counters
> > interface is similar with G4, but it only has 4 performance counters
> > instead of 6.
> >
> > I tested this on a PPC750GX and it seems to work fine.
>
> I'm not too sure about using the same model as 74xx...=20

I've double checked the bits, and it looks to me that what is implemented i=
n=20
op_model_7450.c maps with my User=E2=80=99s Manual IBM PowerPC 750GX and 75=
0GL RISC=20
Microprocessor copy :)


> I have some
> patches that haven't been released yet from Jack Miller to implement the
> full OP support for 750 but they appear to cause crashes.
>

Were they posted somewhere?

> There is a known HW bug in various 750's that basically make the
> performance interrupt unuseable. I -think- it may have been fixed in the
> very latest revision of the 750CL though but I'm not sure.

Yeah, I've read that somewhere, but I did not notice any issues with 750GX =
I=20
am using - so far.

Thanks,
tavi
