Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4714DDEE8
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 22:58:48 +1000 (EST)
Message-Id: <7CAAEE49-56F0-4565-8F1B-374C5E2F9E42@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1215588881.8970.358.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Updates to powerpc.git
Date: Wed, 9 Jul 2008 07:58:38 -0500
References: <1215588881.8970.358.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 2:34 AM, Benjamin Herrenschmidt wrote:

> I've pushed some updates to my version of powerpc.git.
>
> The tree itself is at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>
> It contains 3 branches:
>
>  - merge  : this is for merging with the current stable and doesn't
>             currently contain anything interesting
>
>  - master : this is our current "powerpc.git" tree, it may contain
>             various experimental stuff that may or may not go upstream
>             or may contain dependent patches that we rely on but that
>             are to be merged via some other tree.
>
>  - next   : this is the candidate stuff for linux-next and the next
>             merge window
>
> (Andrew, you -may- want to pull that instead of paulus one until
> he's back from vacation).
>
> Until today, master and next pointed to the same commit, which was
> the same as paulus master and powerpc-next branches. Tonight, I've
> pushed some patches to master that I intend to have in next, but
> I'd like to let them sit in master for a couple of days to make sure
> nothing is badly broken mostly and make sure I didn't screw up in
> my various patch monkeying operations.

What is your intent with the 'master' branch?  I hope you do NOT plan  
on ever rebasing it.  I assume if a patch gets into master and we drop  
it you'll do a git-revert of it?

- k
