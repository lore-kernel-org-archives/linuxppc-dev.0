Return-Path: <timur.tabi@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.183])
	by ozlabs.org (Postfix) with ESMTP id B5D2CDE29B
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 08:14:38 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id o28so94029ele.3
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 14:14:36 -0700 (PDT)
Message-ID: <ed82fe3e0810091414i32ed515di62230a3f4ac78a03@mail.gmail.com>
Date: Thu, 9 Oct 2008 16:14:36 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Sven Luther" <sven@genesi-usa.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
In-Reply-To: <20081009201833.GA14746@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop> <48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
	<48EE3636.7020305@genesi-usa.com>
	<ed82fe3e0810091023j5f746a9cs7f8564c1e6ea8dcb@mail.gmail.com>
	<20081009201833.GA14746@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 9, 2008 at 3:18 PM, Sven Luther <sven@genesi-usa.com> wrote:
>> Not really true.  Having the default be disabled for specific
>> platforms can make a big difference in compile time.
>
> Notice that the defconfigs answer also applies here :)

Not really.  In order for me to create a new defconfig for an embedded
platform, I have to turn *off* CHRP *and* PMAC support, and then turn
on whatever platform I want.

That's the point behind my patch.  The default is on, so anyone
creating a non-CHRP or non-PMAC platform has to do extra work.

And the argument that embedded platforms aren't as important as the
exalted CHRP is bollocks.  All platforms should be treated equally.
And like I said earlier, PMAC platforms aren't even being built any
more, so it's ridiculous to consider that the default.

-- 
Timur Tabi
Linux kernel developer at Freescale
