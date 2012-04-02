Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B166B6EEB
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2012 01:26:14 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
Date: Mon, 2 Apr 2012 15:25:53 +0000
Message-ID: <CAOZdJXW19PFvm7Bb35ZeoaiBpP9jV07YqWhnTn0N-Vu-59WKcw@mail.gmail.com>
References: <alpine.LFD.2.02.1203291544170.14273@spiff>
 <CAOZdJXWyfdMX4mxFqeh=gpyorS9E0aFEhXuxzzvZ_uMV5zhc3g@mail.gmail.com>
In-Reply-To: <CAOZdJXWyfdMX4mxFqeh=gpyorS9E0aFEhXuxzzvZ_uMV5zhc3g@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping!

Kumar, you forgot to deal with this patch for 3.3.  The window for 3.4
is closing rapidly.  There are no objections to my patch.  Could you
please apply it and get it merged into 3.4?  I'm tired of waiting.

On Thu, Mar 29, 2012 at 4:47 PM, Tabi Timur-B04825 <b04825@freescale.com> w=
rote:
> On Thu, Mar 29, 2012 at 3:44 PM, Kumar Gala <galak@kernel.crashing.org> w=
rote:
>>
>> A few minor bug fixes and missing dts updates for 3.4. =A0There got lost=
 in
>> the mix. =A0Sorry for the delay
>
> What about my "don't call of_platform_bus_probe() twice" patch?
> That's still an important fix for the P1022DS.
>
> --
> Timur Tabi
> Linux kernel developer at Freescale



--=20
Timur Tabi
Linux kernel developer at Freescale=
