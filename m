Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0956F1A1921
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 18:21:09 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 53E0F440E24_6A86FE0B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 07:21:04 +0000 (GMT)
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 7F37743E089_6A86FDEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 07:21:02 +0000 (GMT)
Received: by mail-qg0-f45.google.com with SMTP id o11so149455qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 23:21:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453819695.27129.26.camel@buserror.net>
References: <1453811127-28591-1-git-send-email-alessio.bogani@elettra.eu>
 <1453819695.27129.26.camel@buserror.net>
Date: Wed, 27 Jan 2016 08:21:01 +0100
Message-ID: <CAPk1OjHxmT5pZAG=2FfnibKprXZVX9vyrYGUpxj-8eL73ddGFQ@mail.gmail.com>
Subject: Re: powerpc/dts: Move mvme2500.dts back in the right place
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

On 26 January 2016 at 15:48, Scott Wood <oss@buserror.net> wrote:
> On Tue, 2016-01-26 at 13:25 +0100, Alessio Igor Bogani wrote:
>> Commit dc37374b9c83 ("powerpc/fsl: Move Freescale device tree files into
>> fsl folder") move also mvme2500.dts which isn't a device tree for a
>> Freescale board but for an Artesyn one. So move mvme2500.dts back in the
>> right place.
>
> It's not about who makes the board.  In theory it's for all boards with a
> Freescale SoC.  The initial set that was moved was those which use dtsi files
> from the fsl directory.  The motivation was that some of the dtsi files are
> now requiring the preprocessor, and preprocessor includes don't mix well with
> dts includes that change the current directory.

Thank you for your detailed explanation and I'm sorry to have bothered you.

Ciao,
Alessio
