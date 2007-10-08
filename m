Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B028EDDFE7
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 05:41:45 +1000 (EST)
In-Reply-To: <fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
References: <20071008151254.7777.38512.stgit@trillian.cg.shawcable.net>
	<D6497F34-ECE1-481E-B969-E7DDC60BAAFD@kernel.crashing.org>
	<fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <27C642CB-ACC0-4E3E-85AA-8319F56364EB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Eval boards should not need to mess with ROOT_DEV
Date: Mon, 8 Oct 2007 14:41:54 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2007, at 2:03 PM, Grant Likely wrote:

> On 10/8/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> On Oct 8, 2007, at 10:12 AM, Grant Likely wrote:
>>
>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>
>>> I can't see a good reason for eval board platform code to mess with
>>> the
>>> ROOT_DEV value instead of using the default behaviour (so I'm  
>>> writing
>>> this patch to see if anyone will clue me in).
>>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>> ---
>>>
>>>  arch/powerpc/platforms/52xx/efika.c          |    9 ---------
>>>  arch/powerpc/platforms/52xx/lite5200.c       |   12 ------------
>>>  arch/powerpc/platforms/82xx/mpc82xx_ads.c    |    6 ------
>>>  arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 --
>>>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 --
>>>  arch/powerpc/platforms/chrp/setup.c          |   10 ----------
>>>  6 files changed, 0 insertions(+), 41 deletions(-)
>>
>> FYI, 82xx_ads and 885ads don't have this issue in my tree based on
>> fixes from Scott.
>
> So, if I respin this patch to exclude those two platforms, will you
> merge it?  (Efika and Lite5200 only have it because they were cloned
> from CHRP.
>
> Powermac and pseries also do this weirdness.  Should it be removed
> from there too?

We need benh to make a comment about powermac.

I think its ok to remove everywhere but we should see if he has any  
issue.

- k
