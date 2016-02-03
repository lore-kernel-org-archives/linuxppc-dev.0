Return-Path: <runaway@candw.ms>
Received: from smtp687.redcondor.net (smtp687.redcondor.net [208.80.206.87])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B17831A0226
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 09:54:25 +1100 (AEDT)
Subject: Re: commit 9178ba294b6839eeff1a91bed95515d783f3ee6c an A-Eon Tabor
 Board
To: Alexander Graf <agraf@suse.de>
References: <56B1C97A.9010807@candw.ms> <56B26689.8060905@suse.de>
 <56B27BEE.9090503@candw.ms> <56B27D26.5080507@suse.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
From: Julian Margetson <runaway@candw.ms>
Message-ID: <56B28509.2080303@candw.ms>
Date: Wed, 3 Feb 2016 18:54:01 -0400
MIME-Version: 1.0
In-Reply-To: <56B27D26.5080507@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/3/2016 6:20 PM, Alexander Graf wrote:
>
>
> On 02/03/2016 11:15 PM, Julian Margetson wrote:
>> On 2/3/2016 4:43 PM, Alexander Graf wrote:
>>>
>>>
>>> On 02/03/2016 10:33 AM, Julian Margetson wrote:
>>>> Resending as it was attached to and old thread relating to a 
>>>> different motherboard.
>>>>
>>>> On 2/2/2016 9:54 AM, Julian Margetson wrote:
>>>>>
>>>>> Commit 9178ba294b6839eeff1a91bed95515d783f3ee6c prevents building 
>>>>> of kernel 4.1 branch on A-Eon Tabor Board.
>>>>>
>>>>> CC arch/powerpc/math-emu/fsqrt.o
>>>>> arch/powerpc/platforms/85xx/tabor.c:194:2: error: unknown field 
>>>>> ‘power_off’ specified in initializer
>>>
>>> I can't seem to find that file in Linux upstream?
>>>
>>>
>>> Alex
>>>
>>>
>>>
>>
>> It may have been discontinued as the patches used were maintained 
>> along with patches for the (Varisys)  A-Eon Cyrus board
>> which is officially supported from kernel 4.4.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c383ee84e1d575b09d167185d15df24bde25eb15 
>>
>
> I don't quite understand how an internal API change in Linux breaking 
> random external patches is a bug? Either your code is upstream or it 
> can break on every git commit done upstream.
>
>
> Alex
>
>
>

Sorry I am relatively new at this.
If I manage to pinpoint a problem on my powerpc machines I report it . 
Most of them so far have indeed been bugs.
The random external patches were done by person with far greater 
competence than me who are no longer in the picture.
Any  guidance would be greatly  appreciated .

Julian
