Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65430B71A2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2011 06:13:22 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110520144653.GH25179@zod.rchland.ibm.com>
Date: Fri, 20 May 2011 15:13:05 -0500
Message-Id: <EBEB3CA6-696B-4411-8E62-0795A9BC1FD7@kernel.crashing.org>
References: <1305777978.7481.37.camel@pasglop>
	<20110520132328.GA5785@riccoc20.at.omicron.at>
	<20110520135845.GG25179@zod.rchland.ibm.com>
	<20110520143259.GB5785@riccoc20.at.omicron.at>
	<20110520144653.GH25179@zod.rchland.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 20, 2011, at 9:46 AM, Josh Boyer wrote:

> On Fri, May 20, 2011 at 04:32:59PM +0200, Richard Cochran wrote:
>> On Fri, May 20, 2011 at 09:58:45AM -0400, Josh Boyer wrote:
>>> On Fri, May 20, 2011 at 03:23:29PM +0200, Richard Cochran wrote:
>>>> When I try to build 'next' (now at 208b3a4c), it does not compile =
due
>>>> to a change from the following commit.
>>>>=20
>>>>> Benjamin Herrenschmidt (1):
>>>>>      powerpc/smp: Make start_secondary_resume available to all CPU =
variants
>>>>=20
>>>> I would appreciate your help in getting this fixed...
>>>=20
>>> Could you try the patch below?
>>=20
>> Yes, and it both compiles and boots.
>=20
> Thanks for testing!
>=20
> Ben, can you pull this patch in as-is (fixing up the Subject), or do =
you
> need me to resubmit it?


Yeah, we need this all so we can send it to stable for 2.6.39.1

- k=
