Return-Path: <johnny.hacking@gmail.com>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id AA777B7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 01:20:19 +1000 (EST)
Received: by pxi7 with SMTP id 7so649771pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 08:20:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r5txrkfz.fsf@macbook.be.48ers.dk>
References: <cb9ecdfa0909222055x1d691698sb516b5b8f5f81d@mail.gmail.com>
	<87y6o6rvvc.fsf@macbook.be.48ers.dk>
	<cb9ecdfa0909230352w77a37f59h3c7f1e146121f9f6@mail.gmail.com>
	<87r5txrkfz.fsf@macbook.be.48ers.dk>
Date: Wed, 23 Sep 2009 23:20:17 +0800
Message-ID: <cb9ecdfa0909230820k6ebbd589o409e58e2d9b6740c@mail.gmail.com>
Subject: Re: GPIO driver for MPC8313.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many thanks for your help. I will try it.

2009/9/23 Peter Korsgaard <jacmet@sunsite.dk>:
>>>>>> "Johnny" =3D=3D Johnny Hung <johnny.hacking@gmail.com> writes:
>
> =A0Johnny> Thanks, got it. BTW, how to trigger GPIO level in user space
> =A0Johnny> application? I also found
> =A0Johnny> arch/powerpc/platforms/52xx/mpc52xx_gpio.c is a good
> =A0Johnny> example. Any reply is appreciate.
>
> Through sysfs. See 'Sysfs Interface for Userspace' section of
> Documentation/gpio.txt
>
> --
> Bye, Peter Korsgaard
>
