Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 28E21B6FC3
 for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2012 00:37:51 +1000 (EST)
Received: by qaea16 with SMTP id a16so2021927qae.3
 for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2012 07:37:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FA68C98.5070209@gmail.com>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop> <20120401221359.GA31730@gnubox>
 <1333332115.30734.27.camel@pasglop>
 <20120402062826.GC2129@thor.bakeyournoodle.com>
 <4FA68C98.5070209@gmail.com>
Date: Thu, 17 May 2012 16:37:48 +0200
Message-ID: <CADNf2swvQ2gRSjyPpvR5cU+F4WbFTtorw2W3=sFetqgznYLHKg@mail.gmail.com>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: robert.karl.berger@gmail.com, Tony Breeds <tony@bakeyournoodle.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 6, 2012 at 4:37 PM, Robert Berger
<robert.karl.berger@gmail.com> wrote:
> On 04/02/2012 09:28 AM, Tony Breeds wrote:
>> On Mon, Apr 02, 2012 at 12:01:55PM +1000, Benjamin Herrenschmidt wrote:
>>
>>> Ok, I've asked Tony to have a look at splitting the build decision
>>> in arch/powerpc/boot along the same lines as the CPU families... ie onl=
y
>>> wrappers for platforms potentially supported by the built kernel. That
>>> should fix it.
>>
>> Please try this patch. =A0Only lightly tested here. =A0I haven't "split =
up"
>> src-wlib yet as I wanted to verify I'm on the right track.
>
> I can confirm that it fixes the kilauea problem. Builds and runs so far.
> Are you going to push this upstream?
>

I can confirm this too (applied to 3.4-rc7). Tony?

Best regards,
Frank
