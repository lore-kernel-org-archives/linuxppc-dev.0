Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89EF01A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 17:20:51 +1100 (AEDT)
Message-ID: <1415946050.26378.3.camel@concordia>
Subject: Re: powerpc: Fix Text randomization
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vineeth Vijayan <vvijayan@mvista.com>
Date: Fri, 14 Nov 2014 17:20:50 +1100
In-Reply-To: <CAOpNGcsQX1d4=MpHKKKnBotBb11dq55_kQp4PG8OA++U6peqKg@mail.gmail.com>
References: <1412919926-13123-1-git-send-email-vvijayan@mvista.com>
 <20141015020811.7904E14011B@ozlabs.org>
 <CAOpNGcsgX0wVOgMN77+RuKVsb_iHQ7XQk8U_05-up__wC6zuZQ@mail.gmail.com>
 <CAOpNGcsQX1d4=MpHKKKnBotBb11dq55_kQp4PG8OA++U6peqKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-14 at 11:03 +0530, Vineeth Vijayan wrote:
> ping !
> 
> any update on this ? As i understand, only powerpc and s390 uses the
> randomize_et_dyn call; for all other architecture this is an obsolete
> function call.

I asked:

> >> I'm not clear on what has changed to break this?

And you didn't tell me.

> this call for another patch where randomize_et_dyn is removed.

Patches welcome :)

cheers
