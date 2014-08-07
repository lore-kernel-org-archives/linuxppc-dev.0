Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76A701A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 06:13:27 +1000 (EST)
Message-ID: <53E3DDE4.4070203@tabi.org>
Date: Thu, 07 Aug 2014 15:13:24 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: qe: move qe from arch/powerpc to drivers
References: <1403580712-30153-1-git-send-email-B45475@freescale.com>
 <20140730001923.GA4151@home.buserror.net>
 <61b449dd79754d25ace3701ccebe10e2@BLUPR03MB341.namprd03.prod.outlook.com>
 <CAOZdJXW4yw0i2jRALoXUbGudh1_V5fzath_G5yW=Wkz3kreqzA@mail.gmail.com>
 <1407442120.7427.56.camel@snotra.buserror.net> <53E3DD0E.7040802@tabi.org>
 <1407442268.7427.57.camel@snotra.buserror.net>
In-Reply-To: <1407442268.7427.57.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08/07/2014 03:11 PM, Scott Wood wrote:
>>> > >Do you have a better suggestion?
>> >
>> >Leave it where it is?

> We need it on ARM as well.

In that case, drivers/soc is the least-bad option.
