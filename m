Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id AB486DDE26
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 00:47:05 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so79875yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Feb 2009 05:47:04 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 5 Feb 2009 08:47:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ANN] Introducing new "test" branch in powerpc.git tree
Message-ID: <20090205134700.GB3000@yoda.jdub.homelinux.org>
References: <1233806493.4612.65.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233806493.4612.65.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 05, 2009 at 03:01:33PM +1100, Benjamin Herrenschmidt wrote:
>Hoy !
>
>So I've been annoyed for some time by the way we do our preparation for
>the next merge window. The "next" branch is defined as not being rebased
>ever (well, as much as possible), which makes it impossible to just
>stash things early in there and rebase if needed, which is a useful
>exercise in the weeks leading to the merge window to be able to test
>patches, fix them, etc... while keeping a good idea of what's planned to
>go in.
>
>Thus I've created a "test" branch. I'll push it out later today with
>various things pending. For pulls from sub-maintainers, I'll probably
>merge into "next" quickly (ie. a day or two after hitting "test" just
>enough time to find gross problems). That will allow me to be more
>pro-active also at pulling things off the mailing list and sticking them
>there even if some cosmetic changes have been requested to the patch as
>I will have no issue rebasing it when the new patch comes in.

I like this.  So we have:

test -> testing stuff
next -> stuff that's been tested and is queued up for the next release
merge -> fixes for the currently being worked on release

Which begs the question of what master is for.  So far, it's just been
a mirror of next from what I can tell.  Maybe it should just track
Linus' tree?

josh
