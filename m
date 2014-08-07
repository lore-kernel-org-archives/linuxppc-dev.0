Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A12D1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 06:11:25 +1000 (EST)
Message-ID: <1407442268.7427.57.camel@snotra.buserror.net>
Subject: Re: qe: move qe from arch/powerpc to drivers
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@tabi.org>
Date: Thu, 7 Aug 2014 15:11:08 -0500
In-Reply-To: <53E3DD0E.7040802@tabi.org>
References: <1403580712-30153-1-git-send-email-B45475@freescale.com>
 <20140730001923.GA4151@home.buserror.net>
 <61b449dd79754d25ace3701ccebe10e2@BLUPR03MB341.namprd03.prod.outlook.com>
 <CAOZdJXW4yw0i2jRALoXUbGudh1_V5fzath_G5yW=Wkz3kreqzA@mail.gmail.com>
 <1407442120.7427.56.camel@snotra.buserror.net> <53E3DD0E.7040802@tabi.org>
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

On Thu, 2014-08-07 at 15:09 -0500, Timur Tabi wrote:
> On 08/07/2014 03:08 PM, Scott Wood wrote:
> >> >Scott suggests drivers/soc.  I'm not crazy about that, but I don't
> >> >maintain that code any more.
> 
> > Do you have a better suggestion?
> 
> Leave it where it is?

We need it on ARM as well.

-Scott
