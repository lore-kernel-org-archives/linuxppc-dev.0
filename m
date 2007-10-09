Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4455ADE01A
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 01:57:11 +1000 (EST)
In-Reply-To: <fa686aa40710090738s748c17cdn6fa29cc6aea433d9@mail.gmail.com>
References: <47075FA7.3030108@semihalf.com> <470B450E.4020708@semihalf.com>
	<fa686aa40710090738s748c17cdn6fa29cc6aea433d9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3C0AD3C5-70E9-4D39-90A7-82DD2AAD377D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/15] [POWERPC] TQM5200, CM5200 and Motion-PRO support
Date: Tue, 9 Oct 2007 10:57:29 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 9, 2007, at 9:38 AM, Grant Likely wrote:

> On 10/9/07, Marian Balakowicz <m8@semihalf.com> wrote:
>>
>> All,
>>
>> Thanks for the review, will process all the comments and resend
>> updated patches soon.
>
> Make sure you take a look at the 6 patches I posted yesterday.  They
> will probably go in before your changes and will cause conflicts.
>
> Kumar, once I respin the ROOT_DEV patch, how does it look for merging
> my patch set?

most likely, however I think the patchset should go via paul since  
you're touching things all over arch/powerpc (52xx, 4xx, cell,  
pseries, generic code, etc)

- k
