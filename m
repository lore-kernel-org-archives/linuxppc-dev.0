Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
 by ozlabs.org (Postfix) with ESMTP id 5BCB02C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 02:30:23 +1100 (EST)
Message-ID: <51530F3C.1010703@mlbassoc.com>
Date: Wed, 27 Mar 2013 09:24:44 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: remove PReP
References: <1363864206.1390.117.camel@x61.thuisdomein>
 <20130322042159.GC26908@concordia> <1364381223.1345.18.camel@x61.thuisdomein>
 <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
 <1364388152.1345.29.camel@x61.thuisdomein>
In-Reply-To: <1364388152.1345.29.camel@x61.thuisdomein>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013-03-27 06:42, Paul Bolle wrote:
> On Wed, 2013-03-27 at 13:05 +0100, Geert Uytterhoeven wrote:
>> This section is CHRP-specific. The cs4232 driver also worked on the
>> CHRP LongTrail.
>> But I don't remember if the parameter values above also applied to LongTrail.
>> I do remember it didn't work without specifing the right parameters, so you
>> probably want to keep this section.
>
> My reasoning was quite simply that this file was 14 years old so that
> probably nobody is using that stuff anymore. Are people actually using
> CHRP (whatever that is)? Anyhow, cs4232 is mentioned in some other files

Common Hardware Reference Platform - see
   http://en.wikipedia.org/wiki/Common_Hardware_Reference_Platform

> too:
>      $ git grep -l -n cs4232 Documentation/
>      Documentation/powerpc/sound.txt
>      Documentation/sound/alsa/ALSA-Configuration.txt
>      Documentation/sound/alsa/alsa-parameters.txt
>      Documentation/sound/oss/Introduction
>      Documentation/sound/oss/Tropez+
>
> Could these few lines be dumped in one of these (except
> powerpc/sound.txt, of course)?
>

Seeing this stuff go marks the end of an era (the PreP and CHRP
platforms were some of the very first devices to run Linux back
in 1995...)  I just sent my last one to the recycler a few months
back :-(

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
