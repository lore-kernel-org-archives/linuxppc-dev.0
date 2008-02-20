Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by ozlabs.org (Postfix) with ESMTP id A9080DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 12:23:15 +1100 (EST)
Message-ID: <47BB7FDB.3050809@gmail.com>
Date: Tue, 19 Feb 2008 20:18:19 -0500
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: libfdt: More tests of NOP handling behaviour
References: <20080218050925.GH29975@localhost.localdomain>
	<E1JR6vQ-0000h9-2f@jdl.com>
In-Reply-To: <E1JR6vQ-0000h9-2f@jdl.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
>> In light of the recently discovered bug with NOP handling, this adds
>> some more testcases for NOP handling.  Specifically, it adds a helper
>> program which will add a NOP tag after every existing tag in a dtb,
>> and runs the standard battery of tests over trees mangled in this way.
>>
>> For now, this does not add a NOP at the very beginning of the
>> structure block.  This causes problems for libfdt at present, because
>> we assume in many places that the root node's BEGIN_NODE tag is at
>> offset 0.  I'm still contemplating what to do about this (with one
>> option being simply to declare such dtbs invalid).
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Applied.
> 
> BTW, declaring DTBs with BEGIN_NODES not at offset 0
> as invalid seems like a fine choice to me.
> 
> jdl

FWIIW, I vote ditto on declaring DTBs with BEGIN_NODES not at offset 0 
as invalid.  The root being at offset 0 assumption is pretty well 
entrenched and I cannot think of any reason to change it that would be 
worth the effort.

Best regards,
gvb
