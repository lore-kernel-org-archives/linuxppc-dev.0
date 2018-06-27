Return-Path: <schmitzmic@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Fy0C2nY0zF153
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 19:14:19 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id u23-v6so1200141ioc.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 02:14:19 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
To: Gabriel Paubert <paubert@iram.es>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
 <874lhp6i4d.fsf@concordia.ellerman.id.au>
 <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
 <5d4d7ca4-1d2f-268f-e5d2-eddb213e894d@gmail.com>
 <20180627090022.rij2owx5durbc4e6@lt-gp.iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org,
 linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b699a590-2fad-2dd4-f85b-75c771af25f2@gmail.com>
Date: Wed, 27 Jun 2018 21:14:08 +1200
MIME-Version: 1.0
In-Reply-To: <20180627090022.rij2owx5durbc4e6@lt-gp.iram.es>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gabriel,

Am 27.06.2018 um 21:00 schrieb Gabriel Paubert:
> On Wed, Jun 27, 2018 at 05:39:15PM +1200, Michael Schmitz wrote:
>> Ben,
>>
>> Am 27.06.2018 um 15:27 schrieb Benjamin Herrenschmidt:
>>> On Wed, 2018-06-27 at 13:08 +1000, Michael Ellerman wrote:
>>>>> I will rewrite patch 10/12 after Arnd's fixes and this series have all
>>>>> made their way through both powerpc and m68k trees, and submit it
>>>>> separately.
>>>>
>>>> drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
>>>> series is high on his todo list.
>>>
>>> We need at least to pull out a couple of powerbooks we have sitting in
>>> drawers and try it out.
>>
>> No need to root around in drawers - I'm sitting in front of one (G3
>> Titanium) writing this. Let me know if that would help (I've forgotten most
>> of what I knew about powerpc kernels).
>
> A very rare model, all G3 I've seen were plastic, all Titanium were G4 :-)

Right you are - the G3 was the earlier one I used (which was stolen from 
my office). G4 it is, then.

Cheers,

	Michael


>
> 	Cheers,
> 	Gabriel
> 	(still using my Pismo from time to time, but much less since
> 	sleep was broken)
>
