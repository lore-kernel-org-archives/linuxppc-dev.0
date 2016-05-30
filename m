Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJBZy6sfDzDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 19:46:10 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 2465A440E7B_74C0BDEB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:46:06 +0000 (GMT)
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com
 [209.85.220.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 78D4843E09D_74C0BDDF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:46:05 +0000 (GMT)
Received: by mail-qk0-f170.google.com with SMTP id y126so118980870qke.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 02:46:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160516234147.GA22832@home.buserror.net>
References: <1461746125-8055-1-git-send-email-alessio.bogani@elettra.eu>
 <20160516234147.GA22832@home.buserror.net>
Date: Mon, 30 May 2016 11:46:03 +0200
Message-ID: <CAPk1OjE_HsVm6cvvx5FHdTYAMWi2kJ2ChzPxsULS+PoW1CWqDQ@mail.gmail.com>
Subject: Re: [v4,1/1] powerpc/86xx: Add support for Emerson/Artesyn MVME7100
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
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

On 17 May 2016 at 01:41, Scott Wood <oss@buserror.net> wrote:
> On Wed, Apr 27, 2016 at 10:35:25AM +0200, Alessio Igor Bogani wrote:
>> +             bcsr@4,0 {
>> +                     compatible = "artesyn,mvme7100-bcsr";
>> +                     reg = <4 0 0x10000>;
>> +             };
>> +
>> +            serial@5,1000 {
>> +                     cell-index = <2>;
>> +                     device_type = "serial";
>> +                     compatible = "ns16550";
>> +                     reg = <5 0x1000 0x100>;
>> +                     clock-frequency = <1843200>;
>> +                     interrupts = <11 1 0 0>;
>> +             };
>
> The "serial@5,1000" line has spaces where there should be tabs.  There
> are several other instances of this in the patch.
>
> Where did these cell-index values come from?  Why are they needed?

I thought that was the right way to specify the serial number (aka
ttySXX) but I was wrong. I'll remove these.

Thank you very much!

Ciao,
Alessio
