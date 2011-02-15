Return-Path: <meador_inge@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 25670B70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Feb 2011 08:58:48 +1100 (EST)
Message-ID: <4D5AF712.3080509@mentor.com>
Date: Tue, 15 Feb 2011 15:58:42 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
References: <4D55A7F7.5090700@mentor.com>
	<20110214100104.GC4371@pulham.picochip.com>
In-Reply-To: <20110214100104.GC4371@pulham.picochip.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: openmcapi-dev@googlegroups.com, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/14/2011 04:01 AM, Jamie Iles wrote:
> On Fri, Feb 11, 2011 at 03:19:51PM -0600, Meador Inge wrote:
>>      1. Hardware specific bits somewhere under '.../arch/*'.  Drivers
>>         for the MPIC message registers on Power and OMAP4 mailboxes, for
>>         example.
>>      2. A higher level driver under '.../drivers/mailbox/*'.  That the
>>         pieces in (1) would register with.  This piece would expose the
>>         main kernel API.
>>      3. Userspace interfaces for accessing the mailboxes.  A
>>         '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.
>
> How about using virtio for all of this and having the mailbox as a
> notification/message passing driver for the virtio backend?  There are
> already virtio console and network drivers that could be useful for the
> userspace part of it.  drivers/virtio/virtio_ring.c might be a good
> starting point if you thought there was some mileage in this approach.

To be honest, I am not that familiar with 'virtio', but I will take a 
look.  Thanks for the pointer.  Maybe Hollis can speak to this idea more.

> Jamie
>


-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
