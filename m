Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D1102C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 12:40:39 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [2/3][PATCH][upstream] TDM Framework
Date: Wed, 25 Jul 2012 02:40:27 +0000
Message-ID: <500F5C99.6060704@freescale.com>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
 <500EB47F.1040903@freescale.com> <1343173422.2218.2.camel@concordia>
In-Reply-To: <1343173422.2218.2.camel@concordia>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> I agree these values are odd. But there's no rule that you can only use
> an enum if the values are monotonically increasing.
>
> It can still serve as helpful documentation, and reduce the number of
> places you pass a bare int around.

IMHO, an enum should only be used if

1) You are doing real type checking of the enum
2) You don't care what the actual values of each enum is

For this patch, neither is true.

--=20
Timur Tabi
Linux kernel developer at Freescale=
