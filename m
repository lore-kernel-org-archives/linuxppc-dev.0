Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41R69r6B4zzDqgr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 16:54:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Several suspected memory leaks
In-Reply-To: <877em1alut.fsf@concordia.ellerman.id.au>
References: <468d3c5b-d71d-c95b-dab4-ea8c2cebe129@molgen.mpg.de>
 <877em1alut.fsf@concordia.ellerman.id.au>
Date: Thu, 12 Jul 2018 16:54:24 +1000
Message-ID: <87601l7xlr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Hi Paul,
>
> Paul Menzel <pmenzel@molgen.mpg.de> writes:
>> Dear Liunx folks,
>>
>> On a the IBM S822LC (8335-GTA) with Ubuntu 18.04 I built Linux master
>> =E2=80=93 4.18-rc4+, commit 092150a2 (Merge branch 'for-linus'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid) =E2=80=93 wi=
th
>> kmemleak. Several issues are found.
>
> Is this the first time you've tested it?
> Or did these warnings only show up recently?
>
>> ```
>> $ grep KMEMLEAK /boot/config-4.18.0-rc4+
>> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
>> CONFIG_DEBUG_KMEMLEAK=3Dy
>> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3D10000
>> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
>> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
>
>
> I'm not seeing any warnings on my machine here, maybe it's something
> config related. Can you send your full .config ?

Scratch that. I just didn't wait long enough.

cheers
