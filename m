Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1861EDDFCB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 02:01:59 +1000 (EST)
In-Reply-To: <1178207725.17201.33.camel@ld0161-tx32>
References: <1178142818.32136.51.camel@ld0161-tx32>
	<08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
	<1178207725.17201.33.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <10979137-FCDB-40D4-98F4-45CC00AE3358@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
Date: Thu, 3 May 2007 11:01:01 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 3, 2007, at 10:55 AM, Jon Loeliger wrote:

> On Thu, 2007-05-03 at 09:44, Kumar Gala wrote:
>> On May 2, 2007, at 4:53 PM, Jon Loeliger wrote:
>>
>>> From: Jason Jin <jason.jin@freescale.com>
>>>
>>> HD interface and AC97 interface share some pins and they are
>>> enabled at
>>> the same time, In order to use AC97 interface, we need to disable
>>> the HD
>>> interface first.
>>>
>>> Signed-off-by:Jason Jin<jason.jin@freescale.com>
>>> Acked-by: Jon Loeliger <jdl@freescale.com>
>>> ---
>>>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7 ++++++-
>>>  1 files changed, 6 insertions(+), 1 deletions(-)
>>
>> Is the HD feature not used at all?  Is there a AC97 Driver CONFIG_
>> that makes sense to wrap that with?  Just wondering about the mutual
>> exclusion (and how to provide flexibility to the user).
>>
>> - k
>
>
> The ULI supports both the HD and AC97 interfaces, but the 8641
> only supports the AC97 interface.  Thus we can straight disable
> the HD and convert/configure the shared pins to be AC97.  Thus,
> there is no real CONFIG_ need at all.  It's only AC97.  And then
> ultimately, the presence of sound support is controlled by
> the ALSA config options as per normal.

Ok.  I'm guessing HD here isn't hard disk, but some audio thing.

- k
