Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 585642BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Sep 2004 03:25:46 +1000 (EST)
Date: Sat, 25 Sep 2004 13:19:15 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040925152717.F29D4C108D@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409251313470.4491@dell.enoriver.com>
References: <20040925152717.F29D4C108D@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] to support choice of 8xx microcode patch 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 25 Sep 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0409251109150.4235@dell.enoriver.com> you wrote:
>>
>>> Where do you select which CPU type gets  used,  and  adjust  for  the
>>> corresponfding version of the uCode patch?
>>
>> are you referring to the distinction you make in the DENX 2.4 tree,
>> where you distinguish between 850 and non-850 architectures?  since
>
> This is one part of what needs to be done. Also,  the  MPC866  family
> handles relocation differently.

not a problem.  hey, submit a patch. :-)  seriously, you can at least 
suggest what the Kconfig menu choices should look like.  i certainly 
don't feel comfortable doing that, and it's obvious how to add extra 
entries to Kconfig.

>> that appears to be done manually, i see no reason why the same
>> couldn't be done in the patch i submitted.  it would be a trivial
>> change to get the same effect.
>
> You are right. But since you wrote  "this  is  a  *full*  ...  patch"
> (emphasis  by  yourself)  I  somehow  expected  that you covered this
> problem, too.
>
> Sorry if this was a misunderstanding.

no problem.  what i meant by "full" was that it's a completely 
self-contained patch that should (theoretically) drop into place in 
the current linuxppc-2.5 bk tree and should work at least as well as 
what's already there.

i'm not submitting it for immediate inclusion since, as you saw from 
my interminable list of questions/observations, there's still lots of 
trash that can be cleaned up in the current tree.  but it would be 
nice if someone were to apply the patch and at least make sure it 
works in its current form, at least with what it's been designed to 
do.

the point was not to be complete, it was to build an infrastructure so 
that patches were far easier to work with, that's all.

rday
