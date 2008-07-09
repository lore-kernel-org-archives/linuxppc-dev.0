Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8D30DDF86
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 23:42:45 +1000 (EST)
Message-Id: <BA91427F-F52C-4AA5-886B-E8D7527EA203@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080709091846.69b08e34@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Updates to powerpc.git
Date: Wed, 9 Jul 2008 08:40:21 -0500
References: <1215588881.8970.358.camel@pasglop>
	<20080709091846.69b08e34@zod.rchland.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 8:18 AM, Josh Boyer wrote:

> On Wed, 09 Jul 2008 17:34:41 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> I've pushed some updates to my version of powerpc.git.
>>
>> The tree itself is at:
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>>
>> It contains 3 branches:
>>
>>  - merge  : this is for merging with the current stable and doesn't
>>             currently contain anything interesting
>>
>>  - master : this is our current "powerpc.git" tree, it may contain
>>             various experimental stuff that may or may not go  
>> upstream
>>             or may contain dependent patches that we rely on but that
>>             are to be merged via some other tree.
>>
>>  - next   : this is the candidate stuff for linux-next and the next
>>             merge window
>>
>> (Andrew, you -may- want to pull that instead of paulus one until
>> he's back from vacation).
>>
>> Until today, master and next pointed to the same commit, which was
>> the same as paulus master and powerpc-next branches. Tonight, I've
>> pushed some patches to master that I intend to have in next, but
>> I'd like to let them sit in master for a couple of days to make sure
>> nothing is badly broken mostly and make sure I didn't screw up in
>> my various patch monkeying operations.
>
> One thing to point out is that if you decide to only select a few of
> those patches, you'll need to cherry-pick them into your next branch
> (or rebase). That means that when you pull from Linus into your master
> branch during/after the merge window, you'll get all kinds of funny
> merge commits.
>
> If you want to use your master branch as a place for experimental
> stuff, that's fine by me.  But you'll want to keep next separate from
> it so it's as "clean" as possible for those trying to track what is
> definitely going into the next release.
>
> If it were up to me (which it's not), I would have master just track
> Linus, next track what's going into the next release, and "bleeding"  
> or
> "experimental" track stuff that isn't fully vetted yet.  I might start
> doing that with my tree in the very near future.

I do something similar, but my master is a merge of linus and my next  
branch, which is roughly what I think paul did.

> Also, Paul is pretty good about not rebasing his branches when at all
> possible, and I suspect that's why his master and next were often the
> same.  It makes life lots easier for the sub-maintainers and anyone
> trying to track against the tree.  I humbly beg you to keep that  
> going.

I agree and I'm sure linus will tell you how evil it is to rebase as a  
maintainer.

- k
