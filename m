Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A6F05DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 09:28:18 +1100 (EST)
Date: Thu, 4 Dec 2008 01:28:15 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Few patches for galak/powerpc.git next
Message-ID: <20081203222815.GA14386@oksana.dev.rtsoft.ru>
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<AB8A3D8C-2AA7-497B-B4ED-D2192CC358AC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <AB8A3D8C-2AA7-497B-B4ED-D2192CC358AC@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2008 at 01:53:26PM -0600, Kumar Gala wrote:
>
> On Dec 3, 2008, at 1:26 PM, Anton Vorontsov wrote:
>
>> Hi Kumar,
>>
>> Here are few patches queued for the next branch. The patches are
>> mostly USB related. Plus a trivial patch that fixes some sparse
>> warnings.
>>
>> [PATCH 1/5] powerpc/qe: Implement QE Pin Multiplexing API
>> [PATCH 2/5] powerpc: Implement GPIO driver for simple memory-mapped  
>> banks
>> [PATCH 3/5] powerpc/83xx: Add USB Host/Gadget support for MPC8360E-MDS 
>> boards
>> [PATCH 4/5] powerpc/83xx: Add USB Host support for MPC8360E-RDK boards
>> [PATCH 5/5] powerpc/83xx: Fix sparse warnings in mpc836x_mds.c
>>
>> Thanks,
>
> Thanks.. Do you mind doing me a favor and updating the status of any  
> patches that are superceded on http://patchwork.ozlabs.org/

Wow, I can change status of my own patches.. super.

Done, plus I also set 'accepted' state for some patches that
were already merged in powerpc or other trees. Hope this is ok.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
