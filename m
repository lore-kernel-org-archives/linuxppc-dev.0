Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB7561A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 06:08:54 +1000 (EST)
Message-ID: <1407442120.7427.56.camel@snotra.buserror.net>
Subject: Re: qe: move qe from arch/powerpc to drivers
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@tabi.org>
Date: Thu, 7 Aug 2014 15:08:40 -0500
In-Reply-To: <CAOZdJXW4yw0i2jRALoXUbGudh1_V5fzath_G5yW=Wkz3kreqzA@mail.gmail.com>
References: <1403580712-30153-1-git-send-email-B45475@freescale.com>
 <20140730001923.GA4151@home.buserror.net>
 <61b449dd79754d25ace3701ccebe10e2@BLUPR03MB341.namprd03.prod.outlook.com>
 <CAOZdJXW4yw0i2jRALoXUbGudh1_V5fzath_G5yW=Wkz3kreqzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xiaobo Xie <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-07 at 13:57 -0500, Timur Tabi wrote:
> On Wed, Aug 6, 2014 at 3:53 AM, qiang.zhao@freescale.com
> <qiang.zhao@freescale.com> wrote:
> >
> > Actually qe is a kind of IP block, so in my opinion, it is proper to put it under driver/(just in my opinion).
> 
> The QE library is not a driver, however.  It doesn't register as a
> driver with the kernel.

It isn't a complete driver, but it is driver code.

> Scott suggests drivers/soc.  I'm not crazy about that, but I don't
> maintain that code any more.

Do you have a better suggestion?

-Scott
