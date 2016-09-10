Return-Path: <glaubitz@physik.fu-berlin.de>
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWV5t3QdJzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 20:04:02 +1000 (AEST)
Subject: Re: Build regression introduced by
 31cdd0c39c7544ced79da53aa0b7e989f3a39582
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
References: <829134bc-381a-7f45-a99a-0b7e66642246@physik.fu-berlin.de>
 <20160907012356.GA21443@fergus.ozlabs.ibm.com>
 <87a8fhlv2t.fsf@concordia.ellerman.id.au>
 <5f47ce4e-646f-9532-307a-2904c298e64e@physik.fu-berlin.de>
 <87oa3wnks6.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <292771f6-34f6-06f1-6050-2d60751c9489@physik.fu-berlin.de>
Date: Sat, 10 Sep 2016 12:03:48 +0200
MIME-Version: 1.0
In-Reply-To: <87oa3wnks6.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/10/2016 11:53 AM, Michael Ellerman wrote:
>> Thanks for the quick fix!
> 
> I assume by that it worked for you? I'll add a Tested-by: for you?

Not yet. I just got my second PowerPC e500 evaluation board yesterday and the
other board is running 24/7 as an automatic build machine. I will need a few
days to be able to assemble the second machine since I need to order some parts
(SSD, power supply, memory and so on) first.

Cheers,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
