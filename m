Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE16B1A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 01:41:52 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id EAB63440D98_6A8D72CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 14:41:48 +0000 (GMT)
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
 [209.85.192.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 2E0BF43E068_6A8D72CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 14:41:48 +0000 (GMT)
Received: by mail-qg0-f46.google.com with SMTP id o11so7957170qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 06:41:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453904822.27129.44.camel@buserror.net>
References: <CAPk1OjGew2n-17ztcbxcxBXWundeEk5nKQ5MS1HLYR4fiBOjxg@mail.gmail.com>
 <1453904726.27129.42.camel@buserror.net>
 <1453904822.27129.44.camel@buserror.net>
Date: Wed, 27 Jan 2016 15:41:46 +0100
Message-ID: <CAPk1OjGKxzCi58udCL2ocVOoiufetnfgJ1WUcjD-JbQs7Tbq9A@mail.gmail.com>
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

On 27 January 2016 at 15:27, Scott Wood <oss@buserror.net> wrote:
> On Wed, 2016-01-27 at 08:25 -0600, Scott Wood wrote:
>> On Wed, 2016-01-27 at 10:24 +0100, Alessio Igor Bogani wrote:
[...]
>> > I'm wondering if we are allowed to put together configurations of the
>> > 86xx base systems
[...]
>> > mpc86xx_defconfig/mpc86xx_smp_defconfig as like already done for 85xx
>> > ones.
>> Yes, that would be good.
>
> Also consider using config fragments like 85xx now does (and sharing fragments
> with 85xx where appropriate).

It is exactly what I had in mind.

Thank you very much!

Ciao,
Alessio
