Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438441A007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 01:26:09 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 2DCB2440D96_6B35F7DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 14:26:05 +0000 (GMT)
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
 [209.85.220.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 DBF6D43E087_6B35F7BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 14:26:03 +0000 (GMT)
Received: by mail-qk0-f174.google.com with SMTP id o6so21488723qkc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 06:26:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPk1OjGKxzCi58udCL2ocVOoiufetnfgJ1WUcjD-JbQs7Tbq9A@mail.gmail.com>
References: <CAPk1OjGew2n-17ztcbxcxBXWundeEk5nKQ5MS1HLYR4fiBOjxg@mail.gmail.com>
 <1453904726.27129.42.camel@buserror.net>
 <1453904822.27129.44.camel@buserror.net>
 <CAPk1OjGKxzCi58udCL2ocVOoiufetnfgJ1WUcjD-JbQs7Tbq9A@mail.gmail.com>
Date: Thu, 4 Feb 2016 15:26:02 +0100
Message-ID: <CAPk1OjHnF=oi=M5son2vdsZwrhXC6Uy-wTJKpQiZcZMnWLb8KA@mail.gmail.com>
Subject: Re: Question about 86xx
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

On 27 January 2016 at 15:41, Alessio Igor Bogani
<alessio.bogani@elettra.eu> wrote:
> Scott,
>
> On 27 January 2016 at 15:27, Scott Wood <oss@buserror.net> wrote:
>> On Wed, 2016-01-27 at 08:25 -0600, Scott Wood wrote:
>>> On Wed, 2016-01-27 at 10:24 +0100, Alessio Igor Bogani wrote:
> [...]
>>> > I'm wondering if we are allowed to put together configurations of the
>>> > 86xx base systems
> [...]
>>> > mpc86xx_defconfig/mpc86xx_smp_defconfig as like already done for 85xx
>>> > ones.
>>> Yes, that would be good.

There are 6 boards into arch/powerpc/configs/86xx directory. Five of
them are based on dual core 8641 whereas one is based on single core
8610. How should I proceed? Use a single file (mpc86xx_defconfig) or
use two files (mpc86xx_defconfig and mpc86xx_smp_defconfig)?

Thanks a lot!

Ciao,
Alessio
