Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3DFB1A10C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 19:03:04 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id E2135440D7B_4C20033B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 08:02:59 +0000 (GMT)
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com
 [209.85.192.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 51D5843E08B_4C20032F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 08:02:58 +0000 (GMT)
Received: by mail-qg0-f48.google.com with SMTP id z60so5012079qgd.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 00:02:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1421982291.24984.8.camel@ellerman.id.au>
References: <1421655056-7860-1-git-send-email-alessio.bogani@elettra.eu>
 <1421982291.24984.8.camel@ellerman.id.au>
Date: Fri, 23 Jan 2015 09:02:56 +0100
Message-ID: <CAPk1OjEz6Ne7xPdQTyh4aU_MrydRPFM4x-usZi4k0AYRugD1xA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc: refresh mpc85xx_defconfig using "make
 savedefconfig"
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

On 23 January 2015 at 04:04, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2015-01-19 at 09:10 +0100, Alessio Igor Bogani wrote:
>> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
>> ---
>>
>> v1 -> v2
>>       Rebased on v3.19-rc5
>
> In the end I did do a bulk update of all configs, which I think means this is
> obsolete.

Yes you are right.

Could you or Scott merge this http://patchwork.ozlabs.org/patch/419982, please?

Thank you very much!

Ciao,
Alessio
