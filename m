Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 3D4E4DDED9
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 15:20:05 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so15801ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 20:20:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1233806493.4612.65.camel@pasglop>
References: <1233806493.4612.65.camel@pasglop>
Date: Wed, 4 Feb 2009 21:20:04 -0700
Message-ID: <fa686aa40902042020y265f1312w35ad4d4d7c20e230@mail.gmail.com>
Subject: Re: [ANN] Introducing new "test" branch in powerpc.git tree
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 4, 2009 at 9:01 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> [...]
> Now, one important rule is: test will be reset at the beginning of every
> merge window. I will not let it degenerate into the old linuxppc-dev bk
> tree that drifted for years and had things that never got merged.
>
> I'm also not sure whether sub-maintainers should do the same thing with
> a "test" branch of their own. I certainly don't mind if they rebase
> their "next" branches so I'm happy for them to play the same game
> directly into their 'next' branch as long as the day they ask me to pull
> it into the real 'next', they are reasonably confident that the stuff in
> there is stable.

I'm cool with this.  I certainly maintain a branch which is frequently
rebased and that is exactly where I stash stuff as I try to decide
what to do with it.  The only difference is that mine isn't usually
public.  If people want to see it, then I push it out, but otherwise I
just wait until I've got a real pull request.

In fact, in this cycle I did push out to my -next and then had to redo
it before I sent my pull request because one of the middle commits had
an oops (but, nobody bases their patches on my -next tree, so it
doesn't have the same repercussions).

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
