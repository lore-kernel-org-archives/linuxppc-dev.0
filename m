Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96D29DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 16:53:38 +1100 (EST)
Message-Id: <C50C2A8C-956C-49FF-98BC-7F46231AFBF3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1233806493.4612.65.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [ANN] Introducing new "test" branch in powerpc.git tree
Date: Wed, 4 Feb 2009 23:53:32 -0600
References: <1233806493.4612.65.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 4, 2009, at 10:01 PM, Benjamin Herrenschmidt wrote:

> Hoy !
>
> So I've been annoyed for some time by the way we do our preparation  
> for
> the next merge window. The "next" branch is defined as not being  
> rebased
> ever (well, as much as possible), which makes it impossible to just
> stash things early in there and rebase if needed, which is a useful
> exercise in the weeks leading to the merge window to be able to test
> patches, fix them, etc... while keeping a good idea of what's  
> planned to
> go in.
>
> Thus I've created a "test" branch. I'll push it out later today with
> various things pending. For pulls from sub-maintainers, I'll probably
> merge into "next" quickly (ie. a day or two after hitting "test" just
> enough time to find gross problems). That will allow me to be more
> pro-active also at pulling things off the mailing list and sticking  
> them
> there even if some cosmetic changes have been requested to the patch  
> as
> I will have no issue rebasing it when the new patch comes in.
>
> Now, one important rule is: test will be reset at the beginning of  
> every
> merge window. I will not let it degenerate into the old linuxppc-dev  
> bk
> tree that drifted for years and had things that never got merged.
>
> I'm also not sure whether sub-maintainers should do the same thing  
> with
> a "test" branch of their own. I certainly don't mind if they rebase
> their "next" branches so I'm happy for them to play the same game
> directly into their 'next' branch as long as the day they ask me to  
> pull
> it into the real 'next', they are reasonably confident that the  
> stuff in
> there is stable.
>
> For any complaint, see my secretary in the Oort cloud.

Are you going to ask "test" get pulled into Stephen's -next tree?

- k
