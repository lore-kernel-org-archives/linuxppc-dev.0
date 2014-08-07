Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A8AE1A0946
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 04:57:50 +1000 (EST)
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by muin.pair.com (Postfix) with ESMTPSA id 6680A8FC12
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 14:57:46 -0400 (EDT)
Received: by mail-ie0-f169.google.com with SMTP id rd18so5180571iec.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Aug 2014 11:57:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <61b449dd79754d25ace3701ccebe10e2@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1403580712-30153-1-git-send-email-B45475@freescale.com>
 <20140730001923.GA4151@home.buserror.net>
 <61b449dd79754d25ace3701ccebe10e2@BLUPR03MB341.namprd03.prod.outlook.com>
Date: Thu, 7 Aug 2014 13:57:42 -0500
Message-ID: <CAOZdJXW4yw0i2jRALoXUbGudh1_V5fzath_G5yW=Wkz3kreqzA@mail.gmail.com>
Subject: Re: qe: move qe from arch/powerpc to drivers
From: Timur Tabi <timur@tabi.org>
To: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>,
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

On Wed, Aug 6, 2014 at 3:53 AM, qiang.zhao@freescale.com
<qiang.zhao@freescale.com> wrote:
>
> Actually qe is a kind of IP block, so in my opinion, it is proper to put it under driver/(just in my opinion).

The QE library is not a driver, however.  It doesn't register as a
driver with the kernel.

Scott suggests drivers/soc.  I'm not crazy about that, but I don't
maintain that code any more.
