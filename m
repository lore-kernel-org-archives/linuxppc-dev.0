Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D8BC1A0245
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 07:44:05 +1100 (AEDT)
Subject: Re: commit 9178ba294b6839eeff1a91bed95515d783f3ee6c an A-Eon Tabor
 Board
To: Julian Margetson <runaway@candw.ms>
References: <56B1C97A.9010807@candw.ms>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
From: Alexander Graf <agraf@suse.de>
Message-ID: <56B26689.8060905@suse.de>
Date: Wed, 3 Feb 2016 21:43:53 +0100
MIME-Version: 1.0
In-Reply-To: <56B1C97A.9010807@candw.ms>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/03/2016 10:33 AM, Julian Margetson wrote:
> Resending as it was attached to and old thread relating to a different 
> motherboard.
>
> On 2/2/2016 9:54 AM, Julian Margetson wrote:
>>
>> Commit 9178ba294b6839eeff1a91bed95515d783f3ee6c prevents building of 
>> kernel 4.1 branch on A-Eon Tabor Board.
>>
>> CC arch/powerpc/math-emu/fsqrt.o
>> arch/powerpc/platforms/85xx/tabor.c:194:2: error: unknown field 
>> ‘power_off’ specified in initializer

I can't seem to find that file in Linux upstream?


Alex
