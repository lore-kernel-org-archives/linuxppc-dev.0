Return-Path: <jwboyer@gmail.com>
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com
 [209.85.216.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BC9AB6EEC
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2012 00:36:04 +1100 (EST)
Received: by qafi29 with SMTP id i29so2096065qaf.15
 for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2012 06:36:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332633218.2882.16.camel@pasglop>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
Date: Mon, 26 Mar 2012 09:36:00 -0400
Message-ID: <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
 robert.karl.berger@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 24, 2012 at 7:53 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-03-21 at 17:25 +0100, Wolfgang Denk wrote:
>> > > The problem is that for ppc-linux-gcc (GCC) 4.2.2 (which comes
>> with the
>> > > ELDK 4.2) this assembly instruction is not known and the build
>> breaks.
>> >
>> > Sigh. =A0GCC 4.2 is pretty old at this point.
>>
>> But still rock-solid ... =A0We use it a lot, especially as reference for
>> more recent (and sometimes more broken) versions of GCC.
>
> Isn't this a binutils rather than gcc issue ?

Pretty much.

josh
