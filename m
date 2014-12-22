Return-Path: <rickard.strandqvist@spectrumdigital.se>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96C971A011B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 09:11:49 +1100 (AEDT)
Received: by mail-lb0-f173.google.com with SMTP id z12so4504311lbi.32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 14:11:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54985686.7080609@freebsd.org>
References: <1419087601-4889-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1419269161.3786.4.camel@infradead.org> <54985686.7080609@freebsd.org>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Mon, 22 Dec 2014 23:11:24 +0100
Message-ID: <CAFo99gZsG5P6FGLqo02vyCueg4iuSpZqRU5a0BvzvtMhcRs0hw@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: platforms: ps3: repository.c: Remove
 unused function
To: Nathan Whitehorn <nwhitehorn@freebsd.org>
Content-Type: text/plain; charset=UTF-8
Cc: cbe-oss-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>,
 Andre Heider <a.heider@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2014-12-22 18:36 GMT+01:00 Nathan Whitehorn <nwhitehorn@freebsd.org>:
>
> On 12/22/14 09:26, Geoff Levand wrote:
>>
>> On Sat, 2014-12-20 at 16:00 +0100, Rickard Strandqvist wrote:
>>>
>>> Remove the function ps3_repository_write_highmem_info() that is not used
>>> anywhere.
>>
>> NAK
>>
>> ps3_repository_write_highmem_info() is needed by otheros++.  What we
>> need is a kernel patch to add the highmem info to the repository once it
>> is known.
>>
>> These ps3_repository_write_highmem routines are also the only
>> documentation the freeBSD port has as to how the highmem info is (should
>> be) saved in the repository.
>>
>> -Geoff
>>
>>
>
> Yes, we really need this for FreeBSD since that port uses the repository
> directly instead of FDT. Thanks for noticing this. We could adapt FreeBSD to
> use FDT (this is the only non-device-tree PowerPC port), but there hasn't
> been any reason to do that thus far given the availability of the repository
> information.
> -Nathan



Hi

Too bad that did not have the benefit of the patch, but it looks like
something good come because of it anyhow.

Kind regards
Rickard Strandqvist
