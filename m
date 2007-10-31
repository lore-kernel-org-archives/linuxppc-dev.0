Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3E870DDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 23:22:28 +1100 (EST)
Message-ID: <47287339.6040404@ru.mvista.com>
Date: Wed, 31 Oct 2007 15:21:13 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] PowerPC: 440GRx Rainier board support.
References: <20071030164511.GA21973@ru.mvista.com>
	<20071030151608.28a2d706@weaponx.rchland.ibm.com>
In-Reply-To: <20071030151608.28a2d706@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, 30 Oct 2007 19:45:11 +0300
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
>> The following patches add PowerPC 440GRx Rainier board support.
>> The board is almost identical to Sequoia, but doesn't have USB
>> and FPU is not supported.
> 
> So why do we need anything other than the DTS and the defconfig?  I
> would think the sequoia wrapper and platform files would suffice
> completely for this.

Yes, they would, but how to handle the board name in this case?
I mean the resulting image would be cuImage.sequoia for rainier and the 
DTS board name has to be sequoia for rainier too.
I don't now, may be it's not a big deal to call rainier a sequoia though.
What do you think?
Thanks,
Valentine.

> 
> josh
