Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D72FE1A078D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 19:09:03 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 558ED440D6F_4ACE998B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 08:08:56 +0000 (GMT)
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 5762F43E034_4ACE997F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 08:08:55 +0000 (GMT)
Received: by mail-qa0-f44.google.com with SMTP id bm13so1759119qab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jan 2015 00:08:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141205094248.D5C9914011E@ozlabs.org>
References: <1417767462-11584-1-git-send-email-alessio.bogani@elettra.eu>
 <20141205094248.D5C9914011E@ozlabs.org>
Date: Wed, 7 Jan 2015 09:08:53 +0100
Message-ID: <CAPk1OjEfx=1yfb_GUnbdNsw9Y8QfJBeMEebSKiAqDcqwm+sLhA@mail.gmail.com>
Subject: Re: powerpc: refresh mpc85xx_defconfig using "make savedefconfig"
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 5 December 2014 at 10:42, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Fri, 2014-05-12 at 08:17:42 UTC, Alessio Igor Bogani wrote:
>> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
>> ---
>>  arch/powerpc/configs/mpc85xx_defconfig | 57 +++++++---------------------------
>>  1 file changed, 12 insertions(+), 45 deletions(-)
>
> Actually I was planning on doing this in bulk for all the powerpc defconfigs.
>
> Someone remind me to do it late next week once most of next has gone into
> Linus' tree.

Is there any news about this?

Thanks!

Ciao,
Alessio
