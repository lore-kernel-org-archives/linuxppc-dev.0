Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7292FDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 20:59:57 +1000 (EST)
Message-ID: <46BAF36F.4030801@ru.mvista.com>
Date: Thu, 09 Aug 2007 14:58:55 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Jerone Young <jyoung5@us.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: Sequoia 440EPx patches not working
References: <1186598710.5459.7.camel@laptop>
	<20070809030856.GC8261@localhost.localdomain>
In-Reply-To: <20070809030856.GC8261@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Aug 08, 2007 at 01:45:10PM -0500, Jerone Young wrote:
>> Using the Sequoia (AMCC 440EPx) patches recently submitted to the list I
>> am unable to boot to fully boot a uImage built with these patches under
>> Uboot. It appears to hang in very early boot.
> 
> I'm guessing this is an old version of u-boot, that's not device tree
> aware.  That would need a cuImage, not a uImage, and IIRC the posted
> patches didn't yet have cuboot support for Sequoia.
> 

The patches do have cuImage support.
I have a Sequoia board with uBoot 1.1.6 and it boots cuImage fine.
