Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A138B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 12:37:30 +1000 (EST)
Received: by lagw12 with SMTP id w12so1594707lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 19:37:26 -0700 (PDT)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <4FAC35E2.4060900@xenotime.net>
References: <20120510192635.c6f3a55196bbf65f13956e44@canb.auug.org.au>
 <4FAC35E2.4060900@xenotime.net>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 10 May 2012 22:36:55 -0400
Message-ID: <CAP=VYLon7XRoh9s==wGYjUPNAYaTk8QQx7FGRnaDR97v+O-zXA@mail.gmail.com>
Subject: Re: linux-next: Tree for May 10 (net/phy)
To: Randy Dunlap <rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 10, 2012 at 5:40 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On 05/10/2012 02:26 AM, Stephen Rothwell wrote:
>
>> Hi all,
>>
>> Changes since 20120508:
>
>
>
> ERROR: "of_mdio_find_bus" [drivers/net/phy/mdio-mux.ko] undefined!

Not just randconfig, but also powerpc allmodconfig:

http://kisskb.ellerman.id.au/kisskb/buildresult/6291463/

Adding ppc ML to cc.

P.
--


>
> Full randconfig file is attached.
>
> --
> ~Randy
