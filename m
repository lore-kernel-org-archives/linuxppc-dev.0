Return-Path: <aida.mynzhasova@skitlab.ru>
Received: from mail.skitlab.ru (mail.skitlab.ru [217.65.220.135])
 by ozlabs.org (Postfix) with ESMTP id 730092C0369
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 16:52:15 +1100 (EST)
Message-ID: <525B868D.9080806@skitlab.ru>
Date: Mon, 14 Oct 2013 09:52:13 +0400
From: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: "powerpc/83xx: gianfar_ptp: select 1588 clock source through
 dts file" was added twice
References: <525962B2.8010100@skitlab.ru>
 <20131012.171110.246440214474931440.davem@davemloft.net>
In-Reply-To: <20131012.171110.246440214474931440.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.10.2013 01:11, David Miller wrote:
> From: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> Date: Sat, 12 Oct 2013 18:54:42 +0400
>
>> Hi,
>>
>> recently I looked through commits in kernel/git/torvalds/linux.git and
>> I noticed that my patch (old and new version) was added twice (by
>> David S. Miller):
>>
>> e58f6f4fb4eada7867014bfaec898f03afbce5c2
>> 894116bd0e9b7749a0c4b6c62dec13c2a0ccef68
>>
>> I think this is not good, and only
>> e58f6f4fb4eada7867014bfaec898f03afbce5c2 should be added.
>
> Read the code history properly.
>
> First 894116bd0e9b7749a0c4b6c62dec13c2a0ccef68 got applied, as you say
> accidently.  Then I reverted it, see commit
> 3f3f0960aff951c5df6e42ce292d1593a2520646.
>
> Then I applied the correct version which is commit
> e58f6f4fb4eada7867014bfaec898f03afbce5c2.
>
> I didn't respond at all the first time you pointed this out hoping
> you would figure it out on your own.
>

Oh...right...
Please accept my apology.
