Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 74197DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 07:54:43 +1000 (EST)
Date: Tue, 9 Sep 2008 01:54:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: git apply vs. renamed files index mismatch
Message-ID: <20080908215441.GA924@oksana.dev.rtsoft.ru>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
	<48C59B71.3040902@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48C59B71.3040902@freescale.com>
Cc: git@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 08, 2008 at 04:38:57PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
>> I always thought that posting "-M" patches to the public lists is
>> discouraged since it is quite difficult to apply them via patch(1).
>> Also think of non-git users...
>
> I think the substantially enhanced reviewability trumps non-git-users  
> who can follow the rename instructions manually (or fix up their patch  
> utility) if they insist on shunning tools that would make their life 
> easier.

Can't disagree, I myself use git. ;-) But I'm also using standard
patch(1) to test occasional patches... And sometimes linux-X tree
isn't tracked by git (e.g. -mm otm snapshots).

>> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
>> new file mode 100644
>> index 0000000..ae5708e
>> [...]
>> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
>> deleted file mode 100644
>> index ae5708e..0000000
>>
>> That is, if hashes match then it was pure rename.
>
> I suppose, though it's not as easy to spot, and won't help in showing  
> what the differences are if there are any.

..rename and changes ideally go in separate patches.

IIRC this also helps git to track renames (it can easily compare
hashes instead of guessing).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
