Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com
 [209.85.216.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CD5AB6FA3
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Mar 2012 09:53:35 +1100 (EST)
Received: by qafi29 with SMTP id i29so733302qaf.15
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2012 15:53:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
Date: Sat, 31 Mar 2012 00:53:33 +0200
Message-ID: <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 26, 2012 at 3:36 PM, Josh Boyer <jwboyer@gmail.com> wrote:
> On Sat, Mar 24, 2012 at 7:53 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Wed, 2012-03-21 at 17:25 +0100, Wolfgang Denk wrote:
>>> > > The problem is that for ppc-linux-gcc (GCC) 4.2.2 (which comes
>>> with the
>>> > > ELDK 4.2) this assembly instruction is not known and the build
>>> breaks.
>>> >
>>> > Sigh. =A0GCC 4.2 is pretty old at this point.
>>>
>>> But still rock-solid ... =A0We use it a lot, especially as reference fo=
r
>>> more recent (and sometimes more broken) versions of GCC.
>>
>> Isn't this a binutils rather than gcc issue ?
>
> Pretty much.
>

Hi Josh Boyer,

just wanted to add that I'm experiencing the same problem that Robert
reported, but on 8xx instead of 4xx. The mpc8xx does not support the
mfdcrx instruction, so maybe it's more to it than just a binutils bug?

Best regards,
Frank
