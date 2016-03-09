Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 694941A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 19:54:46 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 38713440D9A_6DFE4D2B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 08:54:42 +0000 (GMT)
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 40C5543E099_6DFE4B0F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 08:54:08 +0000 (GMT)
Received: by mail-qg0-f45.google.com with SMTP id t4so35746008qge.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Mar 2016 00:54:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160309063818.GA10069@home.buserror.net>
References: <1457423952-13014-1-git-send-email-alessio.bogani@elettra.eu>
 <20160309063818.GA10069@home.buserror.net>
Date: Wed, 9 Mar 2016 09:54:06 +0100
Message-ID: <CAPk1OjGBKQPxvG1MOzLfxi3muJCCYcqDrtzf7TdfF6CA_xxOmg@mail.gmail.com>
Subject: Re: [1/1] powerpc/embedded6xx: Make reboot works on MVME5100
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Stephen Chivers <schivers@csc.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On 9 March 2016 at 07:38, Scott Wood <oss@buserror.net> wrote:
> On Tue, Mar 08, 2016 at 08:59:12AM +0100, Alessio Igor Bogani wrote:
>> The mtmsr() function hangs during restart. Make reboot works on
>> MVME5100 removing that function call.
[...]
> Do you know why MSR_IP was there to begin with?

I don't know that line came from arch/ppc pre git era.

> Does this board have a
> switch that determines whether boot vectors are high or low (I remember
> some 83xx boards that did), in which case is this fixing one config by
> breaking another?

I haven't found any in the documentation (Installation and Use Manual
6806800A38C February 2011 Edition pag 3 Sect. "Hardware
configuration"). Perhaps in the firmware (PPCBug)?

In any case I added Stephen Chivers in CC who is the author of the
code in hope that he knows better.

Thanks!

Ciao,
Alessio
