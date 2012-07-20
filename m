Return-Path: <jwboyer@gmail.com>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
 [209.85.216.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B61AF2C0394
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 23:27:07 +1000 (EST)
Received: by qcmt36 with SMTP id t36so2092773qcm.15
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 06:27:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1342788865.28608.0.camel@concordia>
References: <1342787714-8415-1-git-send-email-sandeep@freescale.com>
 <1342788865.28608.0.camel@concordia>
Date: Fri, 20 Jul 2012 09:27:03 -0400
Message-ID: <CA+5PVA7XSv7Fbg8DLCZMPmOzMX6uDnxzsAna2gW4RCfH7=eCUg@mail.gmail.com>
Subject: Re: [PATCH][upstream] TDM Framework
From: Josh Boyer <jwboyer@gmail.com>
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sandeep@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 20, 2012 at 8:54 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Fri, 2012-07-20 at 18:05 +0530, sandeep@freescale.com wrote:
>> From: Sandeep Singh <Sandeep@freescale.com>
>>
>> TDM Framework is an attempt to provide a platform independent layer which can
>> offer a standard interface  for TDM access to different client modules.
>> Beneath, the framework layer can house different types of TDM drivers to handle
>> various TDM devices, the hardware intricacies of the devices being completely
>> taken care by TDM drivers.
>
> TDM ?

And here I was thinking I was the only one scratching his head.  All I
could come up with was Time Division Multiplexing.

Protip: If you use an acronym a billion times in a patch, expand it at
least in one place.

josh
