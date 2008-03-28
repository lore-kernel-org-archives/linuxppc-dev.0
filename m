Return-Path: <liml@rtr.ca>
Received: from mail.rtr.ca (rtr.ca [76.10.145.34])
	by ozlabs.org (Postfix) with ESMTP id 271A6DE816
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 06:50:57 +1100 (EST)
Message-ID: <47ED439C.9030400@rtr.ca>
Date: Fri, 28 Mar 2008 15:14:36 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 15/18] ide: remove broken/dangerous HDIO_[UNREGISTER,
	SCAN]_HWIF ioctls
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<20080208004606.17746.90799.sendpatchset@localhost.localdomain>
	<47EBDBAA.2020308@ru.mvista.com>
In-Reply-To: <47EBDBAA.2020308@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>> hdparm explicitely marks HDIO_[UNREGISTER,SCAN]_HWIF ioctls as DANGEROUS
>> and given the number of bugs we can assume that there are no real users:
..

There is the odd user of these, actually.

But the most recent to email me (a few weeks ago),
reported that the SCAN function was no longer working on his kernel.

I'll remove the -R and -U flags completely from hdparm-8.7.

Cheers
