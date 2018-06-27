Return-Path: <schmitzmic@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FsDG6ZmxzF1Cl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 15:39:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id j3-v6so455837pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 22:39:25 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org
References: <cover.1528885172.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
 <874lhp6i4d.fsf@concordia.ellerman.id.au>
 <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <5d4d7ca4-1d2f-268f-e5d2-eddb213e894d@gmail.com>
Date: Wed, 27 Jun 2018 17:39:15 +1200
MIME-Version: 1.0
In-Reply-To: <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Am 27.06.2018 um 15:27 schrieb Benjamin Herrenschmidt:
> On Wed, 2018-06-27 at 13:08 +1000, Michael Ellerman wrote:
>>> I will rewrite patch 10/12 after Arnd's fixes and this series have all
>>> made their way through both powerpc and m68k trees, and submit it
>>> separately.
>>
>> drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
>> series is high on his todo list.
>
> We need at least to pull out a couple of powerbooks we have sitting in
> drawers and try it out.

No need to root around in drawers - I'm sitting in front of one (G3 
Titanium) writing this. Let me know if that would help (I've forgotten 
most of what I knew about powerpc kernels).

Cheers,

	Michael


>
>>
>> Should it just go in via the m68k tree?
>>
>> Or I can create a topic branch to share it between ppc and m68k?
