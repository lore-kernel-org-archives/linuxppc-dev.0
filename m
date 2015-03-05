Return-Path: <jhs@mojatatu.com>
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com
 [209.85.223.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDACC1A0310
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 01:36:02 +1100 (AEDT)
Received: by iery20 with SMTP id y20so23380531ier.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 06:36:00 -0800 (PST)
Message-ID: <54F869CE.1080701@mojatatu.com>
Date: Thu, 05 Mar 2015 09:35:58 -0500
From: Jamal Hadi Salim <jhs@mojatatu.com>
MIME-Version: 1.0
To: Emil Medve <Emilian.Medve@Freescale.com>,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Freescale DPAA FMan FLIB(s)
References: <1425534351-1065-1-git-send-email-Emilian.Medve@Freescale.com>
 <54F84CF1.80702@mojatatu.com> <54F85ECB.3070200@Freescale.com>
In-Reply-To: <54F85ECB.3070200@Freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Igal Liberman <Igal.Liberman@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Emil,

On 03/05/15 08:48, Emil Medve wrote:

> The intent is to upstream the entire suite of the DPAA drivers. All the
> drivers are still WIP, but B/QMan have been already presented to the
> upstream community and this is the first attempt to publish (some low
> level code of) the FMan driver. As we go through our internal checklist
> and in the same time address community feedback we'll soon get the
> drivers to be acceptable for the upstream trees
>
> The first version of the actual Ethernet driver will follow imminently
>
> SDK enablement is a side-effect
>

Meaning? Let me ask the question differently:
Do i need your sdk to use the features exposed or can i use something
like tc to set up the deficit rr or wred or the exposed classifiers
and associated actions?
Would your sdk (via user space direct programming) benefit because you
have pushed these pieces into the kernel?

>> How are you planning to
>> add support for your classifiers, queue schedulers etc?
>
> Yes
>

Yes as in these will be available via linux kernel or via your sdk?

>> Is that a patch
>> on top of this or it is something that sits on user space?
>
> Both. Full DPAA/Ethernet enablement will be present in the kernel. We
> also have support for user-space based approach. I'm unsure where/when
> we might publish that. Of course the SDK is always a place you can turn
> to for all the code we have (in whatever state it might be)
>

the sdk is open source?

cheers,
jamal
